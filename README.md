Community Chanting Book

English, Vol 1: 978-1-78432-031-7
English, Vol 2: 978-1-78432-032-4
English, Retreat Centre: 978-1-78432-041-6

English, Vol 1 A4 Edition: 978-1-78432-173-4

Github: https://github.com/profound-labs/community-chanting-book

test from santacittarama

## Tone Symbols

Put these symbols after the letter you want the tone to appear.

- ꜕: low tone
- ꜓: high tone
- ꜖: Long Low
- \prul{your text}: this will underline the text (long mid)

## Compiling PDF

First intsall a recent TeXLive installation. You can check https://www.tug.org/texlive/

to create the PDF use "make it-vol1" for the web pdf.

### Using Window

First use "wsl" on window terminal (https://learn.microsoft.com/en-us/windows/wsl/install) Tha password on the wsl Ubunutu VM in santacittarama is "sangha" and user is "sangha"

# WIKI 

Please refer to [Wiki Page](https://github.com/profound-labs/community-chanting-book/wiki/Community-Chanting-Book)

## gitignore

The PDF output are ignore in the repo. Because they are in the .gitignore.

# produce final PDF

Make sure to run the make twice so that the TOC is updated with the last structure and page number.