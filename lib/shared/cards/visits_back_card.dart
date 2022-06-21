import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants.dart';

class VisitsBackCard extends StatefulWidget {
  const VisitsBackCard({Key? key}) : super(key: key);

  @override
  State<VisitsBackCard> createState() => _VisitsBackCardState();
}

class _VisitsBackCardState extends State<VisitsBackCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/goodstatus.svg",
                  color: Colors.green,
                ),
                onPressed: () {  },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(3, 5, 10, 5),
                child: Column(
                  children: [
                    Text(
                      '6',
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      AppLocalizations.of(context)!.visitDeviations,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.visitDurationSmall,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  children: [
                    Text(
                      '2',
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      AppLocalizations.of(context)!.visitLeadTime,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.visitInclSgre,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: Column(
                  children: [
                    Text(
                      '12',
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      AppLocalizations.of(context)!.visitLeadTime,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.visitExlSgre,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              new Spacer(),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/approve.svg",
                  color: primaryColor,
                ),
                onPressed: () {  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
