import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef NavigationTypeResolver = NavigationType Function(BuildContext context);

enum NavigationType {
  bottom,
  rail,
  drawer,
  permanentDrawer,
}

class AdaptiveScaffoldDestination {
  final String title;
  final String icon;

  const AdaptiveScaffoldDestination({
    required this.title,
    required this.icon,
  });
}

class AdaptiveNavigationScaffold extends StatefulWidget {
  AdaptiveNavigationScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.endDrawer,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.onNewProjectTap,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    required this.selectedIndex,
    required this.destinations,
    this.onDestinationSelected,
    this.navigationTypeResolver,
    required this.isClient,
    this.drawerHeader,
    this.drawerFooter,
    this.fabInRail = true,
    this.includeBaseDestinationsInMenu = true,
    this.bottomNavigationOverflow = 5,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? endDrawer;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final bool isClient;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final int selectedIndex;
  final List<AdaptiveScaffoldDestination> destinations;
  final ValueChanged<int>? onDestinationSelected;
  final NavigationTypeResolver? navigationTypeResolver;
  final Widget? drawerHeader;
  final Widget? drawerFooter;
  final bool fabInRail;
  final bool includeBaseDestinationsInMenu;
  final int bottomNavigationOverflow;
  final Function()? onNewProjectTap;

  @override
  State<AdaptiveNavigationScaffold> createState() => _AdaptiveNavigationScaffoldState();
}

class _AdaptiveNavigationScaffoldState extends State<AdaptiveNavigationScaffold> {
  NavigationType _defaultNavigationTypeResolver(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 1100) {
      return NavigationType.rail;
    } else {
      return NavigationType.drawer;
    }
  }

  Drawer _defaultDrawer(List<AdaptiveScaffoldDestination> destinations) {
    return Drawer(
      child: ListView(
        children: [
          if (widget.drawerHeader != null) widget.drawerHeader!,
          for (int i = 0; i < destinations.length; i++)
            ListTile(
              leading: Image.asset(
                destinations[i].icon,
                height: 20,
                width: 20,
              ),
              title: Text(destinations[i].title),
              onTap: () {
                widget.onDestinationSelected?.call(i);
              },
            ),
          const Spacer(),
          if (widget.drawerFooter != null) widget.drawerFooter!,
        ],
      ),
    );
  }

  Widget _buildBottomNavigationScaffold() {
    final bottomDestinations = widget.destinations.sublist(
      0,
      math.min(widget.destinations.length, widget.bottomNavigationOverflow),
    );
    final drawerDestinations = widget.destinations.length > widget.bottomNavigationOverflow
        ? widget.destinations.sublist(widget.includeBaseDestinationsInMenu ? 0 : widget.bottomNavigationOverflow)
        : <AdaptiveScaffoldDestination>[];
    return Scaffold(
      body: widget.body,
      appBar: widget.appBar,
      drawer: drawerDestinations.isEmpty ? null : _defaultDrawer(drawerDestinations),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          for (final destination in bottomDestinations)
            BottomNavigationBarItem(
              icon: Image.asset(
                destination.icon,
                height: 20,
                width: 20,
                color: widget.destinations.indexOf(destination) == widget.selectedIndex ? const Color(0xff2949F4) : const Color(0xff333333),
              ),
              label: destination.title,
            ),
        ],
        currentIndex: widget.selectedIndex,
        onTap: widget.onDestinationSelected ?? (_) {},
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }

// Define a global key for the scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildNavigationRailScaffold(context) {
    const int railDestinationsOverflow = 7;
    final railDestinations = widget.destinations.sublist(
      0,
      math.min(widget.destinations.length, railDestinationsOverflow),
    );
    final drawerDestinations =
        widget.destinations.length > railDestinationsOverflow ? widget.destinations.sublist(widget.includeBaseDestinationsInMenu ? 0 : railDestinationsOverflow) : <AdaptiveScaffoldDestination>[];
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        width: 250,
        child: buildColumn(),
      ),
      appBar: widget.appBar,
      body: Row(
        children: [
          MouseRegion(
            onHover: (_) {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: NavigationRail(
              leading: widget.fabInRail ? widget.floatingActionButton : null,
              destinations: [
                for (final destination in railDestinations)
                  NavigationRailDestination(
                    icon: Image.asset(
                      destination.icon,
                      height: 20,
                      width: 20,
                      color: widget.destinations.indexOf(destination) == widget.selectedIndex ? const Color(0xff2949F4) : const Color(0xff333333),
                    ),
                    label: Text(destination.title),
                  ),
                if (!widget.isClient)
                  NavigationRailDestination(
                    icon: Column(
                      children: [
                        Divider(
                          thickness: 1,
                          color: const Color(0xff333333).withOpacity(0.1),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                          child: Image.asset(
                            'asset/images/plus.png',
                            height: 20,
                            width: 20,
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: const Color(0xff333333).withOpacity(0.1),
                        ),
                      ],
                    ),
                    label: const Text(''),
                  ),
                if (!widget.isClient)
                  NavigationRailDestination(
                    icon: GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: Image.asset(
                          'asset/images/next.png',
                          height: 16,
                          width: 16,
                        ),
                      ),
                    ),
                    label: const Text(''),
                  ),
              ],
              selectedIndex: widget.selectedIndex,
              onDestinationSelected: widget.onDestinationSelected ?? (_) {},
            ),
          ),
          Expanded(
            child: widget.body,
          ),
        ],
      ),
      floatingActionButton: widget.fabInRail ? null : widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      persistentFooterButtons: widget.persistentFooterButtons,
      endDrawer: widget.endDrawer,
      bottomSheet: widget.bottomSheet,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      primary: true,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      drawerScrimColor: widget.drawerScrimColor,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
    );
  }

  Widget _buildNavigationDrawerScaffold() {
    return Scaffold(
      body: widget.body,
      appBar: widget.appBar,
      drawer: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        width: 250,
        child: buildColumn(),
      ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      persistentFooterButtons: widget.persistentFooterButtons,
      endDrawer: widget.endDrawer,
      bottomSheet: widget.bottomSheet,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      primary: true,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      drawerScrimColor: widget.drawerScrimColor,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
    );
  }

  Widget _buildPermanentDrawerScaffold() {
    return Row(
      children: [
        Drawer(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              if (widget.drawerHeader != null) widget.drawerHeader!,
              for (final destination in widget.destinations)
                ListTile(
                  leading: Image.asset(
                    destination.icon,
                    height: 20,
                    width: 20,
                    color: widget.destinations.indexOf(destination) == widget.selectedIndex ? const Color(0xff2949F4) : const Color(0xff333333),
                  ),
                  title: Text(destination.title),
                  selected: widget.destinations.indexOf(destination) == widget.selectedIndex,
                  onTap: () => _destinationTapped(destination),
                ),
              const Spacer(),
              if (widget.drawerFooter != null) widget.drawerFooter!,
            ],
          ),
        ),
      ],
    );
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final NavigationTypeResolver navigationTypeResolver = this.widget.navigationTypeResolver ?? _defaultNavigationTypeResolver;
    final navigationType = navigationTypeResolver(context);
    switch (navigationType) {
      case NavigationType.bottom:
        return _buildBottomNavigationScaffold();
      case NavigationType.rail:
        return _buildNavigationRailScaffold(context);
      case NavigationType.drawer:
        return _buildNavigationDrawerScaffold();
      case NavigationType.permanentDrawer:
        return _buildPermanentDrawerScaffold();
    }
  }

  MouseRegion buildColumn() {
    return MouseRegion(
      onExit: (_) {
        _scaffoldKey.currentState?.closeDrawer();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Icon(
                    color: Color(0xFF333333),
                    Icons.energy_savings_leaf_sharp,
                  ),
                ),
                Text(
                  "STRIVEBOARD",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF333333), fontFamily: 'Bicyclette'),
                ),
              ],
            ),
          ),
          Divider(
            color: const Color(0xff333333).withOpacity(0.12),
          ),
          const SizedBox(
            height: 30,
          ),
          if (widget.drawerHeader != null) widget.drawerHeader!,
          for (final destination in widget.destinations)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: widget.destinations.indexOf(destination) == widget.selectedIndex ? const Color(0xff2949F4).withOpacity(0.09) : null,
              ),
              child: ListTile(
                leading: Image.asset(
                  destination.icon,
                  height: 20,
                  width: 20,
                  color: widget.destinations.indexOf(destination) == widget.selectedIndex ? const Color(0xff2949F4) : const Color(0xff333333),
                ),
                title: Text(
                  destination.title,
                  style: TextStyle(
                      color: widget.destinations.indexOf(destination) == widget.selectedIndex ? const Color(0xff2949F4) : const Color(0xff333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Bicyclette'),
                ),
                selected: widget.destinations.indexOf(destination) == widget.selectedIndex,
                onTap: () => _destinationTapped(destination),
              ),
            ),
          if (!widget.isClient)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Divider(
                  color: const Color(0xff333333).withOpacity(0.12),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Links',
                        style: TextStyle(color: Color(0xff333333), fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Bicyclette'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Image.asset(
                          'asset/images/new_project.png',
                          height: 20,
                          width: 20,
                          color: const Color(0xff2949F4),
                        ),
                        title: const Text(
                          'New Project',
                          style: TextStyle(color: Color(0xff333333), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Bicyclette'),
                        ),
                        onTap: widget.onNewProjectTap,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          const Spacer(),
          if (widget.drawerFooter != null) widget.drawerFooter!,
        ],
      ),
    );
  }

  void _destinationTapped(AdaptiveScaffoldDestination destination) {
    final index = widget.destinations.indexOf(destination);
    // if (index != widget.selectedIndex) {
    widget.onDestinationSelected?.call(index);
    // }
  }
}
