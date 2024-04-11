import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var  inputDecoration=InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3.0,
                    )
                  ),

                  fillColor: Colors.brown,
                  filled: true,
                    border: OutlineInputBorder(
                      borderRadius:   BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.brown,
                        width: 3.0,
                      )
                    ),
                   
                    labelStyle: GoogleFonts.kaushanScript(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ));