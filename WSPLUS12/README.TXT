    I hate keystrokes that aren't needed!  It was for this reason that I
    wrote this generic front end routine for my editor and a few other
    programs.  This routine has a few features that make it wonderfully
    powerful for minimizing keystrokes.  I have also enclosed my personal
    configurations for my own editor because some of the features of my
    front end can be used in cunjunction with the editor (in particular my
    GREP-goto facility).

    Since I was raised on WordStar, (I think because of my Borland
    upbringing)  I used the WordStar file 'ws.s' for my basic editor. I
    kept many, but not all, of the commands in your basic set. The end
    product, however was far from an off the standard shelf editor I have
    seen (I have even tinkered with Brief... but went back to TSE Jr.....
    imagine that). I use an enhanced keyboard and take full advantage of
    that in my keystroke commands.

    I wrote a routine called Loader (I originally wrote it for TSE Jr., but
    have since greatly enhanced it for Sem-Edit).  This routine is actually
    very generic, but I made special hooks for Sem-Edit.  One of the big
    annoyances of TSE Jr., was that it could only recognize six file
    extensions... this limitation, though not horrible, was unacceptable
    when you program in five or six different languages.  So I had to write
    a routine that would allow TSE Jr. to recognize as many extensions as
    possible.  I also wanted it to load all the files with allowable
    extensions if they were available (As I'm sure you probably know, there
    is usually a '.h' associated with a '.c'  or '.cpp' file... I wanted it
    to load both the '.c' and the '.h' file).  One other feature was the
    ability to load exact file names in my list of acceptable extensions (I
    didn't want to load files with a '.sys' extension, but I wanted to be
    able to load 'config.sys' without typing the whole name and extension).

    After using that a couple of days, I got more spoiled and wanted more
    power than just recognizing extensions!  So I added a feature that
    would allow the loading of partial filenames with no wildcards (you
    could just type: "q te", and TSE Jr. would load all of the files that
    began with 'te' and had acceptable extensions).  I also added a routine
    so if you typed: "q 'mp' ", TSE Jr. would load all of the acceptable
    files that had 'mp' in their filename.

    Then I added an intelligent 'grep' command,  if you typed the
    following: "q lo /us crt, dos/ *.pas", TSE Jr. would load all files that
    began with 'lo' then would search all of files with a '.pas' extension
    for the three words appearing between the slash's ('US'; 'CRT'; and
    'DOS'... because of a DOS limitation, commas are ignored).  Case is
    ignored and they must appear in that order on the same line. So a file
    with: "Uses Crt, Dos" would be loaded, but "Uses Dos, Crt" would be
    ignored.  This feature allowed my grep to load routines that you could
    only remember parts of the variable names, or you couldn't remember if
    you put a underscore between words in a variable.  This was pretty
    slick... but then Sem-Edit came along and it was time to go to the next
    level.

    One of the 'features' I 'programmed' into Sem-Edit was a way to
    remember the last place you edited in your file, and when the Sem-Edit
    would load these particular files, it would go right to that point.
    This does make a tag file ('SEMEDIT.$E$'), but this is a small price to
    pay for this kind of power!  I then added to my Loader routine a way to
    generate a file I named ('GREPGOTO.$E$'), this file will make my
    Sem-Edit goto the first occurrence of the grep search string in each of
    the loaded files.   I think you can see the power of such a routine!

    My Loader routine is a strange sort of program that expects itself to
    be called from a batch file (Enclosed is 'Q.BAT' as an example). Loader
    actually generates its own batch file (Loader1.Bat) to call Sem-Edit.
    It places Loader1.Bat in a subdirectory defined in the original batch
    file ('Q.BAT' must be modified to point to a directory in your current
    path). Specific parameters are defined in a file also pointed to in the
    original batch file (in this case 'Q.CFG').  I think you can see the
    implications of having a setup like this:  you may use this Loader to
    for multiple programs (I use it for Dos-Edit and 4Print (I also
    included my 4print batch and configuration for another application
    example 4p2.bat and 4p2.cfg)... they can only load one file at a time.
    That is why I have a Single_File option in my config-file).  For a more
    detailed explanation of Loader, just type 'Loader' at the DOS-prompt.

    Enclosed is a copy of my files associated with Sem-Edit, WSPLUS.S and
    WSPLUS.CFG),  Loader and it's associated files (LOADER.EXE, Q.BAT,
    Q.CFG).  Please take a look at them, I don't think you will be
    disapointed.  In fact, you may find them quite useful.

    Sincerely

    Douglas Joseph
    117 Oak Leaf Lane
    Longwood Fl,  32779

    H:  407-862-6218
    W:  407-862-2158

