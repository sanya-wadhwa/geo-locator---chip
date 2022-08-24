import 'package:flutter/material.dart';

class ChipData {
  // an id is useful when deleting chip
  final String id;
  final String name;
  ChipData({required this.id, required this.name});
}

class Animations extends StatefulWidget {
  const Animations({Key? key}) : super(key: key);

  @override
  State<Animations> createState() => _AnimationsState();
}

class _AnimationsState extends State<Animations> {
  // list of chips
  final List<ChipData> _allChips = [];

  // Text controller (that will be used for the TextField shown in the dialog)
  final TextEditingController _textController = TextEditingController();
  // This function will be triggered when the floating actiong button gets pressed
  void _addNewChip() async {
    await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Add a thing:'),
            content: TextField(
              controller: _textController,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _allChips.add(ChipData(
                          id: DateTime.now().toString(),
                          name: _textController.text));
                    });

                    // reset the TextField
                    _textController.text = '';

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'))
            ],
          );
        });
  }

  // This function will be called when a delete icon associated with a chip is tapped
  void _deleteChip(String id) {
    setState(() {
      _allChips.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chips"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Wrap(
          spacing: 5,
          children: _allChips
              .map((chip) => Chip(
                    key: ValueKey(chip.id),
                    label: Text(chip.name),
                    backgroundColor: Colors.amber.shade200,
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    deleteIconColor: Colors.red,
                    onDeleted: () => _deleteChip(chip.id),
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewChip,
        child: const Icon(Icons.add),
      ),
    );
  }
}
