import 'package:flutter/material.dart';
import './dataTypes/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  final List<Question> questions;
  BottomNavBar(this.questions);

  @override
  State<StatefulWidget> createState() {
    return _BottomNavBar();
  }
}

class _BottomNavBar extends State<BottomNavBar> {
  String language="English";
  final List<Entry> data = <Entry>[
    Entry(
      '1.    Introduction To Computer ',
      <Entry>[
        Entry('1.1  Objectives'),
        Entry(
          '1.2  What is Computer? ',
          <Entry>[
            Entry('1.2.1  History of Computers '),
            Entry('1.2.2  Characteristics Of Computer System '),
            Entry('1.2.3  Basic Applications of Computer'),
          ],
        ),
        Entry(
          '1.3  Components of Computer System ',
          <Entry>[
            Entry('1.3.1  Central Processing Unit '),
            Entry('1.3.2  Keyboard, mouse and VDU '),
            Entry('1.3.3  Other Input devices '),
            Entry('1.3.4  Other Output devices '),
            Entry('1.3.5  Computer Memory '),
          ],
        ),
        Entry(
          '1.4  Concept of Hardware and Software',
          <Entry>[
            Entry('1.4.1  Hardware '),
            Entry(
              '1.4.2  Software ',
              <Entry>[
                Entry('1.4.2.1  Application  Software'),
                Entry('1.4.2.2  System Software'),
              ],
            ),
            Entry('1.4.3  Programming Languages '),
          ],
        ),
        Entry('1.5  Representation of Data/Information '),
        Entry('1.6  Concept of Data processing '),
        Entry(
          '1.7  Applications of IECT ',
          <Entry>[
            Entry('1.7.1  e-governance '),
            Entry('1.7.2  Multimedia and Entertainment '),
          ],
        ),
      ],
    ),
    Entry(
      '2.    GUI BASED OPERATING SYSTEM ',
      <Entry>[
        Entry('2.1  Objectives '),
        Entry(
          '2.2  Basics of Operating System ',
          <Entry>[
            Entry('2.2.1  Operating system '),
            Entry('2.2.2  Basics of popular operating system (LINUX, WINDOWS)'),
          ],
        ),
        Entry(
          '2.3 The User Interface ',
          <Entry>[
            Entry('2.3.1  Task Bar '),
            Entry('2.3.2  Icons '),
            Entry('2.3.3  Start Menu '),
            Entry('2.3.4  Running an Application '),
          ],
        ),
        Entry(
          '2.4 Operating System Simple Setting ',
          <Entry>[
            Entry('2.4.1  Changing System Date And Time '),
            Entry('2.4.2  Changing Display Properties '),
            Entry('2.4.3  To Add Or Remove A Windows Component '),
            Entry('2.4.4  Changing Mouse Properties '),
            Entry('2.4.5  Adding and removing Printers '),
          ],
        ),
        Entry('File and Directory Management'),
        Entry('Types of files '),
      ],
    ),
    Entry(
      '3.    ELEMENTS OF WORD PROCESSING',
      <Entry>[
        Entry('3.1  Objectives '),
        Entry(
          '3.2 Word Processing Basics ',
          <Entry>[
            Entry('3.2.1  Opening Word Processing Package '),
            Entry('3.2.2  Menu Bar '),
            Entry('3.2.4  Using The Icons Below Menu Bar'),
          ],
        ),
        Entry(
          '3.3 Opening and closing Documents ',
          <Entry>[
            Entry('3.3.1  Opening Documents '),
            Entry('3.3.2  Save and Save as '),
            Entry('3.3.3  Page Setup'),
            Entry('3.3.4  Print Preview '),
            Entry('3.3.5  Printing of Documents '),
          ],
        ),
        Entry(
          '3.4  Text Creation and manipulation ',
          <Entry>[
            Entry('3.4.1  Document Creation'),
            Entry('3.4.2  Editing Text '),
            Entry('3.4.3  Text Selection '),
            Entry('3.4.4  Cut, Copy and Paste '),
            Entry('3.4.5  Font and Size selection '),
            Entry('3.4.6  Alignment of Text '),
          ],
        ),
        Entry(
          '3.5  Formatting the Text ',
          <Entry>[
            Entry('3.5.1  Paragraph Indenting '),
            Entry('3.5.2  Bullets and Numbering '),
            Entry('3.5.3  Changing case '),
          ],
        ),
        Entry(
          '3.6 Table Manipulation',
          <Entry>[
            Entry('3.6.1  Draw Table'),
            Entry('3.6.2  Changing cell width and height'),
            Entry('3.6.3  Alignment of Text in cell'),
            Entry('3.6.4  Delete / Insertion of row and column'),
            Entry('3.6.5  Border and shading '),
          ],
        ),
      ],
    ),
    Entry('4.    SPREAD SHEET ', <Entry>[
      Entry('4.1  Objectives '),
      Entry('4.2  Elements of Electronic Spread Sheet', <Entry>[
        Entry('4.2.1  Opening of Spread Sheet '),
        Entry('4.2.2  Addressing of Cells '),
        Entry('4.2.3  Printing of Spread Sheet '),
        Entry('4.2.4  Saving Workbooks '),
      ]),
      Entry('4.3  Manipulation of Cells ', <Entry>[
        Entry('4.3.1  Entering Text, Numbers and Dates '),
        Entry('4.3.2  Creating Text, Number and Date Series'),
        Entry('4.3.4  Inserting and Deleting Rows, Column '),
        Entry('4.3.5  Changing Cell Height and Width '),
      ]),
      Entry('4.4  Function and Charts ', <Entry>[
        Entry('4.4.1  Using Formulas '),
        Entry('4.4.2  Function '),
        Entry('4.4.3  Charts '),
      ]),
    ]),
    Entry('5.    COMPUTER COMMUNICATION AND INTERNET ', <Entry>[
      Entry('5.1  Objectives '),
      Entry('5.2  Basics of Computer Networks ', <Entry>[
        Entry('5.2.1  Local Area Network (LAN) '),
        Entry('5.2.2  Wide Area Network (WAN) '),
      ]),
      Entry('5.3 Internet ', <Entry>[
        Entry('5.3.1 Concept of Internet '),
        Entry('5.3.2 Basics of Internet Architecture '),
      ]),
      Entry('5.4  Services on Internet ', <Entry>[
        Entry('5.4.1  World Wide Web and Websites '),
        Entry('5.4.2  Communication on Internet '),
        Entry('5.4.3  Internet Services '),
      ]),
      Entry('5.5  Preparing Computer for Internet Access ', <Entry>[
        Entry('5.5.1  ISPs and examples (Broadband/Dialup/WiFi) '),
        Entry('5.5.2  Internet Access Techniques '),
      ]),
    ]),
    Entry('6.    WWW AND WEB BROWSER ', <Entry>[
      Entry('6.1  Objectives '),
      Entry('6.2  Web Browsing Software ', <Entry>[
        Entry('6.2.1  Popular Web Browsing Software '),
      ]),
      Entry('6.3  Configuring Web Browser '),
      Entry('6.4  Search Engines ', <Entry>[
        Entry('6.4.1  Popular Search Engines / Search for content '),
        Entry('6.4.2  Accessing Web Browser '),
        Entry('6.4.3  Using Favorites Folder '),
        Entry('6.4.4  Downloading Web Pages '),
        Entry('6.4.5  Printing Web Pages '),
      ]),
    ]),
    Entry('7.    COMMUNICATION AND COLLABORATION  ', <Entry>[
      Entry('7.1  Objectives '),
      Entry('7.2  Basics of E-mail ', <Entry>[
        Entry('7.2.1  What is an Electronic Mail '),
        Entry('7.2.2  Email Addressing '),
        Entry('7.2.3  Configuring Email Client '),
      ]),
      Entry('7.3  Using E-mails ', <Entry>[
        Entry('7.3.1  Opening Email Client '),
        Entry('7.3.2  Mailbox: Inbox and Outbox '),
        Entry('7.3.3  Creating and Sending a  E-mail '),
        Entry('7.3.4  Replying to an E-mail message '),
        Entry('7.3.5  Forwarding an E-mail message'),
        Entry('7.3.6  Sorting and Searching emails '),
      ]),
      Entry('7.4  Advance email features ', <Entry>[
        Entry('7.4.1  Sending document by E-mail '),
        Entry('7.4.2  Activating Spell checking '),
        Entry('7.4.3  Using Address book '),
        Entry('7.4.4  Sending Softcopy as attachment '),
        Entry('7.4.5  Handling SPAM '),
      ]),
      Entry('7.5  Instant Messaging and Collaboration ', <Entry>[
        Entry('7.5.1  Using Smiley '),
        Entry('7.5.2  Internet etiquettes '),
      ]),
    ]),
    Entry('8.    MAKING SMALL PRESENTATIONS ', <Entry>[
      Entry('8.1  Objectives'),
      Entry('8.2  Basics', <Entry>[
        Entry('8.2.1  Using PowerPoint '),
        Entry('8.2.2  Opening A PowerPoint Presentation '),
        Entry('8.2.3  Saving A Presentation '),
      ]),
      Entry('8.3  Creation of Presentation ', <Entry>[
        Entry('8.3.1  Creating a Presentation Using a Template '),
        Entry('8.3.2  Creating a Blank Presentation '),
        Entry('8.3.3  Entering and Editing Text '),
        Entry('8.3.4  Inserting And Deleting Slides in a Presentation '),
      ]),
      Entry('8.4  Preparation of Slides ', <Entry>[
        Entry('8.4.1  Inserting Word Table or An Excel Worksheet '),
        Entry('8.4.2  Adding Clip Art Pictures '),
        Entry('8.4.3  Inserting Other Objects '),
        Entry('8.4.4  Resizing and Scaling an Object '),
      ]),
      Entry('8.5  Providing Aesthetics', <Entry>[
        Entry('8.5.1  Enhancing Text Presentation '),
        Entry('8.5.2  Working with Color and Line Style '),
        Entry('8.5.3  Adding Movie and Sound '),
        Entry('8.5.4  Adding Headers and Footers '),
      ]),
      Entry('8.6  Presentation of Slides ', <Entry>[
        Entry('8.6.1  Viewing A Presentation'),
        Entry('8.6.2  Choosing a Set Up for Presentation '),
        Entry('8.6.3  Printing Slides And Handouts'),
      ]),
      Entry('8.7  Slide Show ', <Entry>[
        Entry('8.7.1  Running a Slide Show'),
        Entry('8.7.2  Transition and Slide Timings'),
        Entry('8.7.3  Automating a Slide Show '),
      ]),
    ]),
  ];

  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 1;

  Future<void> examAlert() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('${widget.questions.length} Not Enough Question to take an Exam'),
        content: Text('Connect to internet, go to setting and restore questions from server'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
      }
      if (index == 1) {
        if(widget.questions.length>100){
          Navigator.pushReplacementNamed(context, '/exam');
        }
        else{
          examAlert();
        }
        
      }

      if (index == 2) {
        Navigator.pushReplacementNamed(context, '/manage');
      }
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to exit an App'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  Widget getSyllabus() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => EntryItem(data[index]),
      itemCount: data.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset('assets/banner.png'),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Text(
                    "CCC Syllabus  ",
                    style: TextStyle(fontSize: 22),
                  )),
              Expanded(child: getSyllabus())
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.note), title: Text('Syllabus')),
            BottomNavigationBarItem(
                icon: Icon(Icons.book), title: Text('Exam')),
            BottomNavigationBarItem(
                icon: Icon(Icons.question_answer), title: Text('Community')),
          ],
          fixedColor: Colors.lightBlue[900],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  })  : _icon = icon,
        _color = color,
        _title = title,
        item = BottomNavigationBarItem(
          icon: icon,
          activeIcon: activeIcon,
          title: Text(title),
          backgroundColor: color,
        ),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;

  FadeTransition transition(
      BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(
          Tween<Offset>(
            begin: const Offset(0.0, 0.02), // Slightly down.
            end: Offset.zero,
          ),
        ),
        child: IconTheme(
          data: IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}

class CustomInactiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      decoration: BoxDecoration(
        border: Border.all(color: iconTheme.color, width: 2.0),
      ),
    );
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);
  final String title;
  final List<Entry> children;
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
