import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/data/Note.dart';
import 'package:notes/screens/HomeScreen.dart';
import 'package:notes/screens/ViewNoteScreen.dart';

class NoteTile extends StatelessWidget {
  final Note n;
  const NoteTile({Key? key,required this.n}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewNoteScreen(note: n,))).then((value) => (context as Element).markNeedsBuild());
      },
      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
              Text(n.title,style: TextStyle(fontWeight: FontWeight.bold),),
              // SizedBox(width: MediaQuery.of(context).size.width-20.0,child: Text(n.note,overflow: TextOverflow.ellipsis,softWrap: ,),)
              SizedBox(width: MediaQuery.of(context).size.width-20.0,child: Text(n.note, overflow: TextOverflow.ellipsis,maxLines: 1,softWrap: false,))
            ],),
          ],),
        ),
      ),
    );
  }
}

