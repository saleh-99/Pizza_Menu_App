import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzeria_menu/services/database.dart';
import 'package:provider/provider.dart';
import 'Psges/home_page.dart';
import 'Psges/google_map_page.dart';
import 'Psges/login_page.dart';
import 'Psges/product_page.dart';
import 'components/app_theme.dart';
import 'models/modals.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        Provider<Database>(
          create: (_) => Database(),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'PizzeriaMenu',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return StreamProvider<List<PizzaDetails>>.value(
        initialData: [],
        value: Database().getPizzaDetailsrList(),
        child: NavBarPage(),
      );
    }
    return LoginPageWidget();
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'HomePage';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': HomePage(),
      'ProductPage': ProductPage(),
      'GoogleMap': GoogleMapPage(),
    };
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(4, 1, 4, 4),
              child: Image.asset(
                'assets/images/rhinos-logo.png',
                width: 50,
                height: 50,
                fit: BoxFit.scaleDown,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Text(
                _currentPage,
                style: AppTheme.bodyText1,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              }),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 20,
            ),
            activeIcon: Icon(
              Icons.home,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.productHunt,
              size: 24,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.productHunt,
              size: 24,
            ),
            label: 'Product ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.map,
              size: 24,
            ),
            label: 'Map',
          )
        ],
        backgroundColor: Color(0xFFFAA307),
        currentIndex: tabs.keys.toList().indexOf(_currentPage),
        selectedItemColor: Color(0xFF9D0208),
        unselectedItemColor: Color(0xBB000000),
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
