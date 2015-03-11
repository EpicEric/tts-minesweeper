//
//  json.swift
//  TTS Minesweeper Generator
//
//  Created by Berna on 09/03/15.
//  Copyright (c) 2015 Berna & Epic Eric. All rights reserved.
//

import Foundation

public class json {
    
    class func chooseName() -> String {
        var i = 1
        var path: String
        let basePath = NSHomeDirectory() + "/My Games/Tabletop Simulator/Saves/"
        do {
            path = "TS_Save_\(i).json"
            i++
        } while File.exists(basePath + path)
        return basePath + path
    }
    
    class func createFile(lines: Int, collumns: Int, mines: Int, board: Support.Matrix) -> (Bool, String) {
        var i: Int, j: Int, posX: Double, posZ: Double
        
        var path = chooseName()
        
        var file = File(path: path)
        
        if (NSFileManager().createFileAtPath(path, contents: nil, attributes: nil)){
            posX = (Double) ((-collumns) + ((collumns - 1)%2))
            posZ = (Double) (lines - ((lines - 1)%2))
            file.write( "{\n" +
                "  \"SaveName\": \"Minesweeper_\(lines)x\(collumns)_\(mines)\",\n" + /* 1 */
                "  \"GameMode\": \"Minesweeper\",\n" +
                "  \"Date\": \"3/7/2015 21:15:57 PM\",\n" +
                "  \"Table\": \"Table_RPG\",\n" +
                "  \"Sky\": \"Sky_Field\",\n"
            )
            file.write(
                "  \"Note\": \"MINESWEEPER\\n\\n\(lines) lines\\n\(collumns) collumns\\n\(mines) mines (\((100*mines)/(lines*collumns))%)\",\n" + /* 2 */
                "  \"Rules\": \"\",\n" +
                "  \"PlayerTurn\": \"\",\n" +
                "  \"Grid\": {\n" +
                "    \"Type\": 0,\n" +
                "    \"Lines\": false,\n" +
                "    \"Snapping\": true,\n" +
                "    \"Offset\": true,\n" +
                "    \"xSize\": 2.0,\n" +
                "    \"ySize\": 2.0\n" +
                "  },\n")
            file.write("  \"DrawImage\": \"iVBORw0KGgoAAAANSUhEUgAAAWAAAADQCAYAAAA53LuNAAAFFElEQVR4Ae3QgQAAAADDoPlTH+SFUGHAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgw")
            file.write( "YMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgw")
            file.write("YMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgw")
            file.write("YMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgwYMGDAgAEDBgy8DQx5DAABHyNK3wAAAABJRU5ErkJggg==\",\n")
            file.write("  \"ObjectStates\": [\n" +
                "    {\n" +
                "      \"Name\": \"Deck\",\n" + /* Flag deck */
                "      \"Transform\": {\n" +
                "        \"posX\": 10.9998751,\n" +
                "        \"posY\": 4.29042053,\n" +
                "        \"posZ\": -18.99992,\n" +
                "        \"rotX\": -4.097558E-05,\n" +
                "        \"rotY\": 180.013916,\n" +
                "        \"rotZ\": 180.000015,\n" +
                "        \"scaleX\": 0.625,\n" +
                "        \"scaleY\": 0.625,\n" +
                "        \"scaleZ\": 0.625\n" +
                "      },\n"
            )
            file.write("      \"Nickname\": \"\",\n" +
                "      \"Description\": \"\",\n" +
                "      \"ColorDiffuse\": {\n" +
                "        \"r\": 0.7132509,\n" +
                "        \"g\": 0.7132509,\n" +
                "        \"b\": 0.7132509\n" +
                "      },\n" +
                "      \"Grid\": true,\n" +
                "      \"Locked\": false,\n" +
                "      \"SidewaysCard\": false,\n" +
                "      \"DeckIDs\": [\n"
            )
            for (i = 0; i < mines - 1; i++){
                file.write("        110,\n")
            }
            file.write("        110\n"
                + "      ],\n"
                + "      \"CustomDeck\": {\n"
                + "        \"1\": {\n"
                + "          \"FaceURL\": \"http://i.imgur.com/aHiVv66.jpg\",\n"
                + "          \"BackURL\": \"http://i.imgur.com/xL8AXmY.jpg{Unique}\"\n"
                + "        }\n"
                + "      }\n"
                + "    },\n"
                + "    {\n"
                + "      \"Name\": \"Deck\",\n" /* Interrogation mark deck */
                + "      \"Transform\": {\n"
                + "        \"posX\": 16.9999142,\n"
                + "        \"posY\": 3.957331,\n"
                + "        \"posZ\": -18.99974,\n"
                + "        \"rotX\": -4.73033E-06,\n"
                + "        \"rotY\": 180.010223,\n"
                + "        \"rotZ\": 180.000061,\n"
                + "        \"scaleX\": 0.625,\n"
                + "        \"scaleY\": 0.625,\n"
                + "        \"scaleZ\": 0.625\n"
                + "      },\n"
            )
            file.write("      \"Nickname\": \"\",\n"
                + "      \"Description\": \"\",\n"
                + "      \"ColorDiffuse\": {\n"
                + "        \"r\": 0.7132586,\n"
                + "        \"g\": 0.7132586,\n"
                + "        \"b\": 0.7132586\n"
                + "      },\n"
                + "      \"Grid\": true,\n"
                + "      \"Locked\": false,\n"
                + "      \"SidewaysCard\": false,\n"
                + "      \"DeckIDs\": [\n"
            )
            for (i = 0; i < mines - 1; i++){
                file.write("        111,\n")
            }
            file.write("        111\n"
                + "      ],\n"
                + "      \"CustomDeck\": {\n"
                + "        \"1\": {\n"
                + "          \"FaceURL\": \"http://i.imgur.com/aHiVv66.jpg\",\n"
                + "          \"BackURL\": \"http://i.imgur.com/xL8AXmY.jpg{Unique}\"\n"
                + "        }\n"
                + "      }\n"
                + "    },\n"
            )
            for (i = 1; i <= lines; i++){ /* Regular game cards */
                for (j = 1; j <= collumns; j++){
                    addCard(i, collumn: j, board: board, posX: posX, posZ: posZ, file: file)
                    if (i < lines || j < collumns){
                       file.write(",\n")
                    }
                }
            }
            file.write("\n  ]\n}")
            file.save()
            return (true, path)

        }
        return (false, "")
    }
    
    class func addCard(line: Int, collumn: Int, board: Support.Matrix, posX: Double, posZ: Double, file: File){
        let currentPosX = posX + Double(2 * (collumn - 1))
        file.write("    {\n"
        + "      \"Name\": \"Card\",\n"
        + "      \"Transform\": {\n"
        + "        \"posX\": \(currentPosX),\n"
        )
        let currentPosZ = posZ - Double(2 * (line - 1))
        file.write("        \"posY\": 1.00005647,\n"
        + "        \"posZ\": \(currentPosZ),\n"
        + "        \"rotX\": 1.06699508E-06,\n"
        + "        \"rotY\": 180.000015,\n"
        + "        \"rotZ\": 180.000015,\n"
        + "        \"scaleX\": 0.625,\n"
        + "        \"scaleY\": 0.625,\n"
        + "        \"scaleZ\": 0.625\n"
        + "      },\n"
        )
        let cardNumber = (board[line, collumn] == -1) ? 9 : board[line, collumn]
        file.write("      \"Nickname\": \"\",\n"
            + "      \"Description\": \"\",\n"
            + "      \"ColorDiffuse\": {\n"
            + "        \"r\": 0.713246942,\n"
            + "        \"g\": 0.713246942,\n"
            + "        \"b\": 0.713246942\n"
            + "      },\n"
            + "      \"Grid\": true,\n"
            + "      \"Locked\": false,\n"
            )
        file.write("      \"CardID\": 10\(cardNumber),\n"
            + "      \"SidewaysCard\": false,\n"
            + "      \"CustomDeck\": {\n"
            + "        \"1\": {\n"
            + "          \"FaceURL\": \"http://i.imgur.com/aHiVv66.jpg\",\n"
            + "          \"BackURL\": \"http://i.imgur.com/xL8AXmY.jpg{Unique}\"\n"
            + "        }\n"
            + "      }\n"
        + "    }")
    }
}