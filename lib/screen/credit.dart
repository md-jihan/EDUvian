import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final scholoarshipProvider = StateProvider<String>((ref) => 'Default');
final departmentProvider = StateProvider<String?>((ref) => null);
final Map<String, int> items = {'BoT': 1750, 'VMSP': 1400, 'Default': 2200};
final subjectProvider = StateProvider<List<Subject>>((ref) => []);

final discountProvider = StateProvider<bool>((ref) => false);
final Map<String, List<Subject>> department = {
  'CSE': cseSubjects,
  'EEE': eeeSubjects,
  'EBSC in CSE': cseSubjects,
  'EBSC in EEE': eeeSubjects,
};

class Subject {
  final String Code;
  final String Title;
  final double Credit;

  Subject(this.Code, this.Title, this.Credit);

  @override
  String toString() => '$Code - $Title';
}

final List<Subject> cseSubjects = [
  Subject("AA099", "Academic Reading and Writing", 0),
  Subject("AA150", "Fundamentals of Quantitative Reasoning", 0),
  Subject("AA200", "Student Development Seminars", 0),
  Subject("ENG111", "Advanced Academic Reading & Writing", 3),
  Subject("ENG112", "Advanced Academic Listening & Speaking", 1.5),
  Subject("BNG101", "Bangla Language and Literature", 3),
  Subject("HIS101", "History of the Emergence of Bangladesh", 3),
  Subject("PSC100", "Introduction to Political Science", 3),
  Subject("IGLE300", "International Graduate Leadership Experience", 3),
  Subject("SOC101", "Introduction to Sociology", 3),
  Subject("JRN101", "Mass Communication in Contemporary Society", 3),
  Subject("BCH101", "Bangladesh Culture and Heritage", 3),
  Subject("BPH101", "Bangladesh Political History", 3),
  Subject("PSY101", "Principles of Psychology", 3),
  Subject("ANT101", "Physical Anthropology", 3),
  Subject("FRN101", "Elementary French I", 3),
  Subject("SDA101", "Public Speaking", 3),
  Subject("PHI102", "Moral Problems", 3),
  Subject("PSC150", "World Politics", 3),
  Subject("ECO203", "Bangladesh Economy", 3),
  Subject("ENG300", "Critical Reading and Writing Skills", 3),
  Subject("IGS101", "Introduction to Gender and Women’s Studies", 3),
  Subject("IIR101", "Introduction to International Relations Theory", 3),
  Subject("WPP101", "Western Political Philosophy", 3),
  Subject("BUS300", "Business Communication", 3),
  Subject("HUM105", "Bangladesh Studies", 3),
  Subject("HUM107", "Industrial Management and Law", 3),
  Subject("HUM201", "Macro & Microeconomics", 3),
  Subject("HUM203", "Communication Skills for Engineers", 3),
  Subject("HUM211", "Entrepreneurship for Engineers", 3),
  Subject("HUM301", "Financial & Managerial Accounting", 3),
  Subject("HUM303", "Sociology & Ethics", 3),
  Subject("HUM305", "Professional Ethics & Environmental Protection", 3),
  Subject("IPD400", "Integrated Professional Development", 3),
  Subject("BNG101", "Bangla Language and Literature", 3),
  Subject("HIS101", "History of the Emergence of Bangladesh", 3),
  Subject("PSC100", "Introduction to Political Science", 3),
  Subject("IGLE300", "International Graduate Leadership Experience", 3),
  Subject("SOC101", "Introduction to Sociology", 3),
  Subject("JRN101", "Mass Communication in Contemporary Society", 3),
  Subject("BCH101", "Bangladesh Culture and Heritage", 3),
  Subject("BPH101", "Bangladesh Political History", 3),
  Subject("PSY101", "Principles of Psychology", 3),
  Subject("ANT101", "Physical Anthropology", 3),
  Subject("FRN101", "Elementary French I", 3),
  Subject("SDA101", "Public Speaking", 3),
  Subject("PHI102", "Moral Problems", 3),
  Subject("PSC150", "World Politics", 3),
  Subject("ECO203", "Bangladesh Economy", 3),
  Subject("ENG300", "Critical Reading and Writing Skills", 3),
  Subject("IGS101", "Introduction to Gender and Women’s Studies", 3),
  Subject("IIR101", "Introduction to International Relations Theory", 3),
  Subject("WPP101", "Western Political Philosophy", 3),
  Subject("BUS300", "Business Communication", 3),
  Subject("HUM105", "Bangladesh Studies", 3),
  Subject("HUM107", "Industrial Management and Law", 3),
  Subject("HUM201", "Macro & Microeconomics", 3),
  Subject("HUM203", "Communication Skills for Engineers", 3),
  Subject("HUM211", "Entrepreneurship for Engineers", 3),
  Subject("HUM301", "Financial & Managerial Accounting", 3),
  Subject("HUM303", "Sociology & Ethics", 3),
  Subject("HUM305", "Professional Ethics & Environmental Protection", 3),
  Subject("IPD400", "Integrated Professional Development", 3),
  Subject("ME102", "Engineering Drawing", 1.5),
  Subject("EEE111", "Introduction to Electrical Engineering", 3),
  Subject("EEE112", "Introduction to Electrical Engineering Laboratory", 1.5),
  Subject("CSE223", "Digital Electronics & Pulse Technique", 3),
  Subject("CSE224", "Digital Electronics & Pulse Technique Laboratory", 1.5),
  Subject("PHY101", "Physics", 3),
  Subject("PHY102", "Physics Laboratory", 1.5),
  Subject("CHEM201", "Chemistry", 3),
  Subject(
    "MATH107",
    "MATH-I: Differential Calculus, Co-ordinate Geometry & Complex Variables",
    3,
  ),
  Subject(
    "MATH203",
    "MATH-IV: Fourier Analysis, Differential Equations & Laplace Transforms",
    3,
  ),
  Subject(
    "MATH207",
    "MATH-II: Integral Calculus, Vector Analysis & Linear Algebra",
    3,
  ),
  Subject("MATH205", "MATH-III: Numerical Analysis", 3),
  Subject("MATH301", "MATH-V: Probability & Statistics", 3),
  Subject("CSE111", "Computer Fundamentals and Programming Basics", 3),
  Subject(
    "CSE112",
    "Computer Fundamentals and Programming Basics Laboratory",
    1.5,
  ),
  Subject("CSE113", "Structured Programming Language", 3),
  Subject("CSE114", "Structured Programming Language Laboratory", 1.5),
  Subject("CSE123", "Object Oriented Programming Language", 3),
  Subject("CSE124", "Object Oriented Programming Language Laboratory", 1.5),
  Subject("CSE115", "Discrete Mathematics", 3),
  Subject("CSE211", "Data Structure", 3),
  Subject("CSE212", "Data Structure Laboratory", 1.5),
  Subject("CSE215", "Digital Logic Design", 4),
  Subject("CSE216", "Digital Logic Design Laboratory", 1.5),
  Subject("CSE221", "Algorithms", 3),
  Subject("CSE222", "Algorithms Laboratory", 1.5),
  Subject("CSE225", "Database Management System", 3),
  Subject("CSE226", "Database Management System Laboratory", 1.5),
  Subject("CSE242", "Web Development", 1.5),
  Subject("CSE311", "Operating System", 3),
  Subject("CSE312", "Operating System Laboratory", 1.5),
  Subject("CSE313", "Data Communication", 3),
  Subject("CSE315", "Microprocessor and Interfacing", 3),
  Subject("CSE316", "Microprocessor & Interfacing Laboratory", 1.5),
  Subject("CSE317", "Computer Organization and Architecture", 3),
  Subject("CSE319", "Compiler Design", 3),
  Subject("CSE320", "Compiler Design Lab", 1.5),
  Subject("CSE321", "Computer Graphics", 3),
  Subject("CSE322", "Computer Graphics Lab", 1.5),
  Subject("CSE325", "Computer Networks", 3),
  Subject("CSE326", "Computer Networks Laboratory", 1.5),
  Subject("CSE327", "Artificial Intelligence", 3),
  Subject("CSE328", "Artificial Intelligence Lab", 1.5),
  Subject("CSE342", "IoT Based Project Development", 1.5),
  Subject("CSE366", "Mobile App Development", 1.5),
  Subject("CSE411", "Software Engineering", 3),
  Subject("CSE443", "Neural Network and Fuzzy Systems", 3),
  Subject("CSE463", "Machine Learning for Big Data Analytics", 3),
  Subject("CSE464", "Python based project Development", 1.5),
  Subject("CSE400", "Project/Thesis", 6),
  Subject("CSE301", "Data Warehousing and Mining", 3),
  Subject("CSE303", "Introduction to Bioinformatics", 3),
  Subject("CSE307", "Mobile Computing and Applications", 3),
  Subject("CSE308", "Mobile Computing and Applications Lab", 1.5),
  Subject("CSE309", "Distributed Systems", 3),
  Subject("CSE337", "Multimedia Theory", 3),
  Subject("CSE429", "Software Project Management", 3),
  Subject("CSE435", "Pattern Recognition", 3),
  Subject("CSE436", "Pattern Recognition Lab", 1.5),
  Subject("CSE439", "Digital Image Processing", 3),
  Subject("CSE440", "Digital Image Processing Lab", 1.5),
  Subject("CSE447", "Robotics", 3),
  Subject("CSE455", "Business Process Reengineering", 3),
  Subject("ETE309", "Digital Signal Processing", 3),
  Subject("ETE310", "Digital Signal Processing Laboratory", 1.5),
  Subject("ETE431", "Mobile Cellular & Wireless Communication", 3),
  Subject("ETE435", "Digital Communication", 3),
  Subject("ETE436", "Digital Communication Laboratory", 1.5),
  Subject("EEE213", "Electronics Devices & Circuits", 3),
  Subject("EEE214", "Electronics Devices & Circuits Lab", 1.5),
  Subject("EEE317", "Electrical Drives & Instrumentation", 3),
  Subject("EEE318", "Electrical Drives & Instrumentation Lab", 1.5),
  Subject("CSE457", "Cyber Security", 3),
  Subject("CSE459", "Network Security", 3),
];

final List<Subject> eeeSubjects = [
  Subject("AA099", "Academic Reading and Writing", 0),
  Subject("AA150", "Fundamentals of Quantitative Reasoning", 0),
  Subject("AA200", "Student Development Seminars", 0),

  Subject("ENG111", "Advanced Academic Reading & Writing", 3),
  Subject("ENG112", "Advanced Academic Listening & Speaking", 1.5),

  Subject("BNG101", "Bangla Language and Literature", 3),
  Subject("HIS101", "History of the Emergence of Bangladesh", 3),
  Subject("PSC100", "Introduction to Political Science", 3),
  Subject("IGLE300", "International Graduate Leadership Experience", 3),
  Subject("SOC101", "Introduction to Sociology", 3),
  Subject("JRN101", "Mass Communication in Contemporary Society", 3),
  Subject("BCH101", "Bangladesh Culture and Heritage", 3),
  Subject("BPH101", "Bangladesh Political History", 3),
  Subject("PSY101", "Principles of Psychology", 3),
  Subject("ANT101", "Physical Anthropology", 3),
  Subject("FRN101", "Elementary French I", 3),
  Subject("SDA101", "Public Speaking", 3),
  Subject("PHI102", "Moral Problems", 3),
  Subject("PSC150", "World Politics", 3),
  Subject("ECO203", "Bangladesh Economy", 3),
  Subject("ENG300", "Critical Reading and Writing Skills", 3),
  Subject("IGS101", "Introduction to Gender and Women’s Studies", 3),
  Subject("IRI101", "Introduction to International Relations Theory", 3),
  Subject("WPP101", "Western Political Philosophy", 3),
  Subject("BUS300", "Business Communication", 3),
  Subject("HUM105", "Bangladesh Studies", 3),
  Subject("HUM107", "Industrial Management and Law", 3),
  Subject("HUM201", "Macro & Microeconomics", 3),
  Subject("HUM203", "Communication Skills for Engineers", 3),
  Subject("HUM211", "Entrepreneurship for Engineers", 3),
  Subject("HUM301", "Financial & Managerial Accounting", 3),
  Subject("HUM303", "Sociology & Ethics", 3),
  Subject("HUM305", "Professional Ethics & Environmental Protection", 3),
  Subject("IPD400", "Integrated Professional Development", 3),

  Subject("CSE103", "Computer Programming", 3),
  Subject("CSE104", "Computer Programming Laboratory", 1.5),
  Subject("ME101", "Basic Mechanical Engineering", 3),
  Subject("CE101", "Engineering Drawing & Electrical Service Design", 1.5),
  Subject("EEE403", "Instrumentation & Measurement", 3),
  Subject("EEE404", "Instrumentation & Measurement Laboratory", 1.5),

  Subject("PHY101", "Physics", 3),
  Subject("PHY102", "Physics Laboratory", 1.5),
  Subject("CHEM201", "Chemistry", 3),

  Subject("MATH101", "MATH-I-Differential Calculus & Integral Calculus", 3),
  Subject("MATH103", "MATH-II-Complex Variable & Vector Analysis", 3),
  Subject(
    "MATH207",
    "MATH-III-Matrices, Linear Algebra & Co-ordinate Geometry",
    3,
  ),
  Subject(
    "MATH209",
    "MATH-IV-Fourier Analysis, Differential Equations & Laplace Transforms",
    3,
  ),
  Subject("MATH301", "MATH-V-Probability & Statistics", 3),

  Subject("EEE101", "Electrical Circuits-I", 3),
  Subject("EEE102", "Electrical Circuits-I Laboratory", 1.5),
  Subject("EEE103", "Electrical Circuits-II", 3),
  Subject("EEE104", "Electrical Circuits-II Laboratory", 1.5),
  Subject("EEE203", "Electrical Machines-I", 3),
  Subject("EEE204", "Electrical Machines-I Laboratory", 1.5),
  Subject("EEE205", "Electronics-I", 3),
  Subject("EEE206", "Electronics-I Laboratory", 1.5),
  Subject("EEE207", "Electrical Machines-II", 4),
  Subject("EEE208", "Electrical Machines-II Laboratory", 1.5),
  Subject("EEE217", "Digital Electronics", 4),
  Subject("EEE218", "Digital Electronics Lab", 1.5),
  Subject("EEE301", "Electronics-II", 3),
  Subject("EEE302", "Electronics-II Laboratory", 1.5),
  Subject("EEE303", "Signal and Systems", 3),
  Subject("EEE306", "Mathematical Methods in Engineering", 1.5),
  Subject("EEE307", "Science of Materials", 3),
  Subject("EEE309", "Digital Signal Processing", 3),
  Subject("EEE310", "Digital Signal Processing Laboratory", 1.5),
  Subject("EEE313", "Microprocessors & Micro Controllers", 3),
  Subject("EEE314", "Microprocessors & Micro Controllers Laboratory", 1.5),
  Subject("EEE317", "Transmission & Distribution of Electrical Power", 3),
  Subject("EEE300", "Machine Design and Simulation Lab", 1.5),
  Subject("EEE320", "Project - (embedded programming)", 1.5),
  Subject("EEE401", "Power Electronics", 3),
  Subject("EEE402", "Power Electronics Laboratory", 1.5),
  Subject("EEE311", "Control Systems", 3),
  Subject("EEE312", "Control Systems Laboratory", 1.5),
  Subject("EEE405", "Fundamental Communication Engineering", 4),
  Subject("EEE406", "Fundamental Communication Engineering Laboratory", 1.5),
  Subject("EEE407", "Semiconductor Devices", 3),
  Subject("EEE409", "VLSI", 3),
  Subject("EEE410", "VLSI Laboratory", 1.5),
  Subject("EEE451", "Power System Analysis", 3),
  Subject("EEE452", "Power System Analysis Laboratory", 1.5),
  Subject("EEE400", "Project/Thesis", 6),

  Subject("EEE411", "Microwave Engineering", 3),
  Subject("EEE412", "Microwave Engineering Laboratory", 1.5),
  Subject("EEE431", "Cellular Mobile Communication", 3),
  Subject("EEE437", "Wireless Communication", 3),
  Subject("EEE433", "Optical Fiber Communication", 3),
  Subject("EEE435", "Digital Communication", 3),
  Subject("EEE436", "Digital Communication Laboratory", 1.5),
  Subject("EEE438", "Wireless Communication Lab", 1.5),
  Subject("EEE439", "Random Signal Processing", 3),
  Subject("EEE441", "Telecommunication Engineering", 3),
  Subject("EEE443", "Data Communication & Computer Networks", 3),
  Subject("EEE445", "Biomedical Instrumentation", 3),
  Subject("EEE447", "Telecommunication Switching", 3),
  Subject("EEE449", "Wireless Protocol and Ad-Hoc Network", 3),
  Subject("EEE490", "Multimedia Communication", 3),
  Subject("EEE493", "Internet of Things", 3),
  Subject("EEE495", "Internet Security and Networking", 3),
];

class CreditCalculation extends ConsumerStatefulWidget {
  const CreditCalculation({super.key});

  @override
  ConsumerState<CreditCalculation> createState() => _CreditCalculationState();
}

class _CreditCalculationState extends ConsumerState<CreditCalculation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EDUvian',
          style: TextStyle(
            shadows: [
              Shadow(
                blurRadius: 2,
                color: const Color.fromARGB(97, 0, 0, 0),
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 169, 28, 18),
        foregroundColor: Colors.white,

        leading: IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back,
            shadows: [
              Shadow(
                blurRadius: 2,
                color: const Color.fromARGB(97, 0, 0, 0),
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      return DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Select Scholarship',
                          labelStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue.shade200,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue.shade200,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue.shade200,
                              width: 2.0,
                            ),
                          ),
                        ),
                        dropdownColor: Colors.lightBlue.shade200,

                        value: ref.watch(scholoarshipProvider),
                        items:
                            items.keys.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            ref.read(scholoarshipProvider.notifier).state =
                                newValue;
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Consumer(
                    builder: (context, ref, child) {
                      return DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Select Department',
                          labelStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue.shade200,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue.shade200,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue.shade200,
                              width: 2.0,
                            ),
                          ),
                        ),
                        dropdownColor: Colors.lightBlue.shade200,
                        items:
                            department.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          ref.read(departmentProvider.notifier).state =
                              newValue;
                          ref.read(subjectProvider.notifier).state = [];
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  if (ref.watch(departmentProvider) != null)
                    Consumer(
                      builder: (context, ref, child) {
                        final departmentf = ref.watch(departmentProvider);
                        final departmentList = department[departmentf] ?? [];

                        return Autocomplete(
                          optionsBuilder: (TextEditingValue subjectName) {
                            if (subjectName.text == '') return departmentList;
                            return departmentList.where(
                              (subject) =>
                                  subject.Code.toLowerCase().contains(
                                    subjectName.text.toLowerCase(),
                                  ) ||
                                  subject.Title.toLowerCase().contains(
                                    subjectName.text.toLowerCase(),
                                  ),
                            );
                          },
                          displayStringForOption:
                              (Subject option) => option.toString(),
                          onSelected: (Subject subjects) {
                            final current = [...ref.read(subjectProvider)];
                            if (!current.contains(subjects)) {
                              current.add(subjects);
                              ref.read(subjectProvider.notifier).state =
                                  current;
                            }
                          },
                          fieldViewBuilder: (
                            context,
                            controller,
                            focusNode,
                            onFieldSubmitted,
                          ) {
                            return TextField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                labelText: 'Search Subject',

                                labelStyle: TextStyle(color: Colors.black54),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.lightBlue.shade200,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.lightBlue.shade200,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.lightBlue.shade200,
                                    width: 2.0,
                                  ),
                                ),

                                suffixIcon:
                                    ref.watch(subjectProvider).isNotEmpty
                                        ? IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () {
                                            controller.clear();
                                            focusNode.requestFocus();
                                          },
                                        )
                                        : null,
                              ),
                            );
                          },
                          optionsViewBuilder: (context, onSelected, options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 4.0,
                                color: Colors.lightBlue.shade50,
                                surfaceTintColor: Colors.lightBlue.shade300,
                                child: SizedBox(
                                  height: (options.length * 50.0).clamp(
                                    0,
                                    50.0 * 4,
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      final option = options.elementAt(index);
                                      return ListTile(
                                        title: Text(option.toString()),
                                        onTap: () => onSelected(option),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),

                  Consumer(
                    builder: (context, ref, child) {
                      final selected = ref.watch(subjectProvider);

                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Column(
                          children: [
                            SizedBox(
                              height: ((selected.length * 90.0).clamp(
                                0,
                                90.0 * 3,
                              )),
                              child: ListView.builder(
                                padding: EdgeInsets.all(0),
                                itemCount: selected.length,
                                itemBuilder: (context, index) {
                                  final subject = selected[index];
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 2,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.lightBlue.shade200,
                                      ),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(
                                        "${subject.Code} - ${subject.Title}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Credit: ${subject.Credit}",

                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          final updated = [
                                            ...ref.watch(subjectProvider),
                                          ]..remove(subject);
                                          ref
                                              .read(subjectProvider.notifier)
                                              .state = updated;
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.redAccent.shade200,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final selected = ref.watch(subjectProvider);
              final totalCredit = selected.fold<double>(
                0,
                (prev, subject) => prev + subject.Credit,
              );
              final rate = items[ref.watch(scholoarshipProvider)] ?? 0;
              double totalCost = rate * totalCredit;
              if (ref.watch(discountProvider)) {
                totalCost *= 0.95;
              }
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 0,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border(top: BorderSide(color: Colors.grey.shade400)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Credit: ${totalCredit}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              "Per Credit Cost: ${items[ref.watch(scholoarshipProvider)].toString()} Tk",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              "Total Cost: ${totalCost.toStringAsFixed(2)} Tk",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            return Column(
                              children: [
                                Checkbox(
                                  activeColor: Colors.lightBlue.shade300,
                                  value: ref.watch(discountProvider),
                                  onChanged: (value) {
                                    ref.read(discountProvider.notifier).state =
                                        value ?? false;
                                  },
                                ),
                                Text('Apply 5% Discount'),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
