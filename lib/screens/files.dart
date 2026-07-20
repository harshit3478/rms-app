import 'package:rmsnewmodule/screens/patientDetails.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/root.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Files extends StatefulWidget {
  Files({
    Key? key,
    this.backArrow = false
  }) : super(key: key);

  final bool backArrow;

  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  String?email;
  String? uid;

  TextEditingController _searchController = TextEditingController();
  List _finalPatientFilesList = [];
  List _searchQueryPatientList = [];
  late Future isDataLoaded;
  AuthModal? auth;

  

  @override
  void initState() {
    
    super.initState();
    User?user= FirebaseAuth.instance.currentUser;
    if(user!=null){
      setState(() {
        this.email = user.email;
        this.uid = user.uid;
      });
    }

    //
    // FirebaseAuth.instance!.currentUser().then((value) {
    //
    //   //print(uid + 'this is the uid');
    // }).catchError((e) {
    //   print(e);
    // });
      init();
    _searchController.addListener(_onSearchChanged);
  }

  init() async{
    AuthModal auth1 = await AuthCache().getAuth();
     setState(() {
      auth = auth1;
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDataLoaded = getPatientFiles();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var patientSnapshot in _finalPatientFilesList) {
        var name =
            PatientDataModel.fromSnapshot(patientSnapshot).name!.toLowerCase();
        var phnum = PatientDataModel.fromSnapshot(patientSnapshot).phnum!.toLowerCase();
        var uniId = PatientDataModel.fromSnapshot(patientSnapshot).id!.toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())
          || phnum.contains(_searchController.text.toLowerCase())
          || uniId.contains(_searchController.text.toLowerCase())
        ) {
          showResults.add(patientSnapshot);
        }
      }
    } else {
      showResults = List.from(_finalPatientFilesList);
    }
    setState(() {
      _searchQueryPatientList = showResults;
    });
  }

  getPatientFiles() async {
    AuthModal finalUid = await AuthCache().getAuth();
    String finalfinaluid = finalUid.uid;
    var patientData = await FirebaseFirestore.instance
        .collection("Patient")
        .where("uid", isEqualTo: finalfinaluid).get();

    // Deduplicate: keep only the latest record per patient ID
    final Map<String, DocumentSnapshot> latestByID = {};
    for (final doc in patientData.docs) {
      final d = (doc.data() as Map<String, dynamic>?) ?? {};
      final id = (d['ID'] as String?) ?? '';
      final key = id.isNotEmpty ? id : doc.id;
      final existing = latestByID[key];
      if (existing == null) {
        latestByID[key] = doc;
      } else {
        final existingNo = int.tryParse(((existing.data() as Map<String, dynamic>?)?['app no'] as String?) ?? '0') ?? 0;
        final newNo = int.tryParse((d['app no'] as String?) ?? '0') ?? 0;
        if (newNo >= existingNo) latestByID[key] = doc;
      }
    }
    final uniqueDocs = latestByID.values.toList();

    setState(() {
      _finalPatientFilesList = uniqueDocs;
    });
    searchResultsList();
    return uniqueDocs;
  }

  @override
  Widget build(BuildContext context) {
    //print(auth?.uid);
    //print(uid ?? '' + 'test uid');
    return Scaffold(
      appBar: AppBar(
        leading: widget.backArrow 
        ? InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        )
        : SizedBox()
        ,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(
        //         Icons.cloud_download,
        //         color: Color(0xA60D79DD),
        //         size: 30,
        //       ),
        //       onPressed: () {})
        // ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Text('Patients', style: AppTextStyles.heading1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name, phone or unique ID',
                  hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
                  prefixIcon: const Icon(Icons.search, color: AppColors.iconDefault),
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _searchQueryPatientList.length,
                  itemBuilder: (BuildContext content, int i) => Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                      child: buildPatientList(
                        context,
                        _searchQueryPatientList[i],
                        // _searchQueryPatientList[i],
                      ),
                    ),
                  )
                )
              )
          ],
        ),
      ),
    );
  }
}

Widget buildPatientList(
  BuildContext context,
  DocumentSnapshot document,
) {
  final patientData = PatientDataModel.fromSnapshot(document);

  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => PatientDetails(
            name: patientData.name,
            id: patientData.id,
            rmsPsg: patientData.rmsPsg,
            appNo: patientData.appNo,
            address: patientData.address,
            gender: patientData.gender,
            rmsDS: patientData.rmsDs,
            rmsPS: patientData.rmsPs,
            vpt: patientData.vpt,
            fis: patientData.fis,
            rmsBS: patientData.rmsBs,
            age: patientData.age,
            phnum: patientData.phnum,
            date: patientData.date,
            time: patientData.time,
            img: patientData.webUrl,
            index: document.reference,
            dataModel: patientData
          )
        )
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: const Border.fromBorderSide(BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: patientData.webUrl != null && patientData.webUrl!.isNotEmpty
                ? NetworkImage(patientData.webUrl!)
                : null,
            radius: 30,
            backgroundColor: AppColors.primaryLight,
            child: patientData.webUrl == null || patientData.webUrl!.isEmpty
                ? const Icon(Icons.person, color: AppColors.primary, size: 26)
                : null,
          ),
          const SizedBox(width: 8),
          Container(height: 60, width: 2, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${patientData.name ?? ''} · #${patientData.id ?? ''}',
                  style: AppTextStyles.label,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.location_on_outlined, color: AppColors.primary, size: 13),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${patientData.address?.isNotEmpty == true ? patientData.address : 'N/A'}'
                      '  ·  ${patientData.date?.isNotEmpty == true ? patientData.date : 'N/A'}',
                      style: AppTextStyles.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]),
                const SizedBox(height: 2),
                Row(children: [
                  const Icon(Icons.phone_outlined, color: AppColors.primary, size: 13),
                  const SizedBox(width: 4),
                  Text(
                    '${patientData.phnum?.isNotEmpty == true ? patientData.phnum : 'N/A'}'
                    '  ·  Test #${patientData.appNo ?? 'N/A'}',
                    style: AppTextStyles.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textHint, size: 20),
        ],
      ),
    ),
  );
}

class PatientDataModel {
  String? name;
  String? id;
  String? appNo;
  String? age;
  String? address;
  String? gender;
  String? rmsDs;
  String? rmsPs;
  String? phnum;
  String? vpt;
  String? fis;
  String? rmsBs;
  String? webUrl;
  String? date;
  String? time;
  String? uid;
  String? rmsPsg;

  String? dcdas1;
  String? dcdas2;
  String? dcdas3;
  String? dcdas4;
  String? dcdas5;
  String? dcdas6;
  String? dcdas7;
  String? dcdas8;

  String? pcdas1;
  String? pcdas2;
  String? pcdas3;
  String? pcdas4;
  String? pcdas5;
  String? pcdas6;
  String? pcdas7;
  String? pcdas8;
  
  String? mcdasf1;
  String? mcdasf2;
  String? mcdasf3;
  String? mcdasf4;
  String? mcdasf5;
  String? mcdasf6;
  String? mcdasf7;
  String? mcdasf8;

  String? note;
  String? favScale;
  

  PatientDataModel(
      this.name,
      this.address,
      this.age,
      this.appNo,
      this.date,
      this.fis,
      this.gender,
      this.id,
      this.phnum,
      this.rmsBs,
      this.rmsDs,
      this.rmsPs,
      this.rmsPsg,
      this.time,
      this.uid,
      this.vpt,
      this.webUrl,
      
      this.dcdas1,
      this.dcdas2,
      this.dcdas3,
      this.dcdas4,
      this.dcdas5,
      this.dcdas6,
      this.dcdas7,
      this.dcdas8,

      this.pcdas1,
      this.pcdas2,
      this.pcdas3,
      this.pcdas4,
      this.pcdas5,
      this.pcdas6,
      this.pcdas7,
      this.pcdas8,
      
      this.mcdasf1,
      this.mcdasf2,
      this.mcdasf3,
      this.mcdasf4,
      this.mcdasf5,
      this.mcdasf6,
      this.mcdasf7,
      this.mcdasf8,
      
      this.note,
      this.favScale

    );

  PatientDataModel.fromSnapshot(DocumentSnapshot snapshot) {
    final d = (snapshot.data() as Map<String, dynamic>?) ?? {};
    name    = d['name'];
    id      = d['ID'];
    appNo   = d['app no'];
    age     = d['age'];
    address = d['address'];
    gender  = d['gender'];
    rmsDs   = d['RMS Digital Anxiety Scale'];
    phnum   = d['phnum'];
    vpt     = d['vpt scale score'];
    fis     = d['fis scale score'];
    webUrl  = d['url'];
    date    = d['date'];
    time    = d['time'];
    uid     = d['uid'];
    rmsPsg  = d['rms ps girls'] ?? d['rms ps scale score'];

    dcdas1 = d['dcdas1']; dcdas2 = d['dcdas2'];
    dcdas3 = d['dcdas3']; dcdas4 = d['dcdas4'];
    dcdas5 = d['dcdas5']; dcdas6 = d['dcdas6'];
    dcdas7 = d['dcdas7']; dcdas8 = d['dcdas8'];

    pcdas1 = d['pcdas1']; pcdas2 = d['pcdas2'];
    pcdas3 = d['pcdas3']; pcdas4 = d['pcdas4'];
    pcdas5 = d['pcdas5']; pcdas6 = d['pcdas6'];
    pcdas7 = d['pcdas7']; pcdas8 = d['pcdas8'];

    mcdasf1 = d['mcdasf1']; mcdasf2 = d['mcdasf2'];
    mcdasf3 = d['mcdasf3']; mcdasf4 = d['mcdasf4'];
    mcdasf5 = d['mcdasf5']; mcdasf6 = d['mcdasf6'];
    mcdasf7 = d['mcdasf7']; mcdasf8 = d['mcdasf8'];

    note     = d['note'];
    favScale = d['fav scale'];
  }

}
