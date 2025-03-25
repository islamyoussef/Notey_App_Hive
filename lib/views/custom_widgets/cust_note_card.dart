import 'package:flutter/material.dart';

class CustNoteCard extends StatelessWidget {
  const CustNoteCard({
    super.key,
    required this.cardColor,
    required this.title,
    required this.details,
    required this.cardDate,
    required this.openModalSheet,
    required this.onDeleteClick
  });

  final String title;
  final String details;
  final Color cardColor;
  final String cardDate;
  final VoidCallback openModalSheet;
  final VoidCallback onDeleteClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, right: 16, left: 16),
      padding: EdgeInsets.only(top: 16,bottom: 16,right: 8,left: 8),
      decoration: BoxDecoration(
        color:cardColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: InkWell(
              onTap: openModalSheet,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            subtitle: Text(
              details,
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromRGBO(0, 0, 0, 0.7),
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 3,
            ),
            trailing: IconButton(onPressed: onDeleteClick,
              icon: const Icon(Icons.delete, color: Colors.black87,),
            ),
          ),

          Text(cardDate, style: TextStyle(
              fontSize: 12,
              color: Colors.black54
          ),),
        ],
      ),
    );
  }
}
