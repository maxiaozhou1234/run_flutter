import 'package:flutter/cupertino.dart';
import 'package:photoflutter/model/app_state_model.dart';
import 'package:provider/provider.dart';
import 'styles.dart';
import 'page/product_list_tab.dart';
import 'page/search_tab.dart';
import 'page/shopping_cart_tab.dart';

class Shopping extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShoppingState();
  }
}

class _ShoppingState extends State<Shopping> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppStateModel>(
        builder: (context) => AppStateModel()..loadProducts(),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: CupertinoColors.darkBackgroundGray,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), title: Text('Products')),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.search), title: Text('Search')),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.shopping_cart),
                  title: Text('Cart')),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(builder: (context) {
                  return CupertinoPageScaffold(
                    child: ProductListTab(),
                  );
                });
              case 1:
                return CupertinoTabView(builder: (context) {
                  return CupertinoPageScaffold(
                    child: SearchTab(),
                  );
                });
              case 2:
                return CupertinoTabView(builder: (context) {
                  return CupertinoPageScaffold(
                    child: ShoppingCartTab(),
                  );
                });
            }
            return null;
          },
        ));
  }
}
