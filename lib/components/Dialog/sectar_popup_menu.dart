import '../../package/config_packages.dart';

class SectorPopupMenu extends StatelessWidget {
  final List<PopupMenuItemModel> itemList;
  final Function(String)? onSelected;

  const SectorPopupMenu({super.key, required this.itemList, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: PopupMenuButton<String>(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white,
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return itemList.map((item) {
            return PopupMenuItem<String>(
              value: item.value,
              child: ListTile(
                leading: Image.asset(
                  item.image,
                  color: item.imageColor,
                  height: 25,
                ),
                title: Text(
                  item.text,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            );
          }).toList();
        },
      ),
    );
  }
}

class PopupMenuItemModel {
  final String value;
  final String text;
  final String image;
  final Color imageColor;

  PopupMenuItemModel({
    required this.value,
    required this.text,
    required this.image,
    required this.imageColor,
  });
}
