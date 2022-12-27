import 'package:flutter/material.dart';
import 'package:flutter_diet_tips/Appetotor/Provider/languageprovider.dart';
import 'package:flutter_diet_tips/generated/l10n.dart';
import 'package:flutter_diet_tips/util/ConstantData.dart';
import 'package:provider/provider.dart';

class Languages extends StatefulWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    build(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF757575),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Bottomsheetcontainer(
                  onTap: () {
                    setState(() {
                      context
                          .read<ChangeLanguageProvider>()
                          .chnagelanguage("ar");
                    });
                    Navigator.pop(context);
                  },
                  icon: 'assets/images/SAFlag.jpg',
                  text: "Arabic",
                ),
                const SizedBox(
                  height: 12,
                ),
                Bottomsheetcontainer(
                  onTap: () async {
                    setState(() {
                      context
                          .read<ChangeLanguageProvider>()
                          .chnagelanguage("en");
                    });
                    Navigator.pop(context);
                  },
                  icon: 'assets/images/ukFlag.jpg',
                  text: "English",
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Bottomsheetcontainer extends StatefulWidget {
  VoidCallback onTap;
  String text;
  String icon;
  Bottomsheetcontainer(
      {Key? key, required this.onTap, required this.text, required this.icon})
      : super(key: key);

  @override
  State<Bottomsheetcontainer> createState() => _BottomsheetcontainerState();
}

class _BottomsheetcontainerState extends State<Bottomsheetcontainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage(widget.icon),
                  ),
                )),
                Expanded(
                    child: Text(
                  widget.text,
                  style: TextStyle(
                      fontFamily: ConstantData.fontFamily, color: Colors.white),
                ))
              ],
            ),
          )),
    );
  }
}
