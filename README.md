Community Chanting Book

English, Vol 1: 978-1-78432-031-7
English, Vol 2: 978-1-78432-032-4
English, Retreat Centre: 978-1-78432-041-6

English, Vol 1 A4 Edition: 978-1-78432-173-4

Github: https://github.com/profound-labs/community-chanting-book

## Parsing with rythmic marks

To start from fresh, use: `make fresh`

`make parse` will ask you for the folder, choose `chapters/english-marked` and choose your option.

`make vol1m` will compile the PDF. 

### Adding exeption

You can add word or line that are not detected as pali by adding them in `helpers/parser/paliWords.json`

Sometimes, pali is added to latex commands, you can add replaces in `helpers/parser/replaceCommands.json`

`helpers/parser/skipFiles.json` contains the files that are not parsed.