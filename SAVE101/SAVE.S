/*
 *        Module : SAVE.S
 *
 *        Author : Edgar Ray Payne, Jr.
 *          Date : 08.21.94
 *     Copyright : (c)1994 by Sirius Software Services  All Rights Reserved.
 *                 (c)1994 by Edgar Ray Payne, Jr.  All Rights Reserved.
 *
 *       Version : 1.01
 *      Modified : 08.21.94  @  22:14:23
 *
 * 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
 *??
 *  Notes:
 *
 *  Replacement save functions implementing different save schemes
 *??
 *??I use two different types of backup storage, local and global.  Local
 *??backups are used mostly for my programming source code.  Since I
 *??frequently have modules of the same name for different projects, I don't
 *??want the different files mixed.  Local backups are placed in a subdir of
 *??the files home location called BAK\.  Global backups are stored in a
 *??single location.  I use D:\BACKUP\.
 *??
 *??Along with the two types of storage there are three levels of backup;
 *??blocked, normal and incremental.
 *??
 *?? o Blocked is self-explanatory.  Even with backups turned on files of
 *??   this type never get backed-up.  A good example of this type is a
 *??   backup file itself.
 *??
 *?? o Normal backups are the same as the default TSE backups except that
 *??   they support the backup directory scheme described above.
 *??
 *?? o Incremental backups are a bit different from other backup schemes in
 *??   that multiple copies of a file are retained.  Each consecutive backup
 *??   is given an incremental number as an extension.  For example the first
 *??   time a file is saved, a backup is made with .000 as the extension.
 *??   The next save creates .001, the next .002 and so on.  No provision is
 *??   made for when .999 is passed, but the backups should be weeded out
 *??   long before this happens.
 *??
 *??I use incremental backups for source code where I usually save a file
 *??every couple of minutes.  This protects me should a power failure or
 *??network crash occur, but I might be several saves along before I realize
 *??I need to go back to a long gone prior version of a file.  With the
 *??incremental save I just have to scan the backups to find the point I want
 *??to return to.
 *??
 * 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
 *??
 *??Credits:
 *??
 *?? Thanks go to Mel Hulse for getting me pointed in the right direction on
 *?? this.  His response to a message I sent through the echos a while back
 *?? and subsequent code he sent helped to kick my brain into gear with
 *?? this problem.  Thanks Mel.
 *??
 * 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
 *
 *   Modification history:
 *
 *   Date     I     VS    Changes
 * 컴컴컴컴  컴컴  컴컴  컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
 * 08.21.94  ERPJ  1.00  Initial version.
 * 컴컴컴컴  컴컴  컴컴  컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
 * 08.21.94  ERPJ  1.01  OOPS.  Typo in last minute changes.  Corrected and
 *                       re-uploaded to SemWare BBS
 *
 */

integer proc mSaveFile()
   //
   //  These two vars control the placement of the local and global backups
   //
   string
      LocalDir[65]  = SplitPath( CurrFilename(), _DRIVE_ | _PATH_ ) + "BAK\",
      GlobalDir[65] = "D:\BACKUP\"

   //
   //  These are the lists of extensions
   //
   //    LocalExt - These files are forced to a local backup
   //    IncExt   - These files get an incremental backup
   //    NoBackUp - These files have backups blocked
   //
   //  All other files are treated as global backups with the default
   //  TSE backup extension.
   //
   string
      LocalExt[65]  = " .s .c .pas .prg .ch .dh .lh .frc .fh " ,
      IncExt[65]    = " .s .c .pas .prg .ch .dh .lh .frc .fh .bat .btm .ini .sys " ,
      NoBackUp[65]  = " .cya .erp .org .bak .tmp .old .new "

   string
      BackUpDir[65] = "",                               // Backup location
      FName[65] = SplitPath( CurrFilename(), _NAME_ ),  // Root name
      TName[65],                                        // Work name
      FExt[4] = Query( BackupExt ),                     // Backup ext to use
      TExt[4] = " " + CurrExt() + " ",                  // Current ext
      savName[65]                                       // Saved file name

   integer
      retVal    = FALSE,                    // Default return value
      DoBackups = Query( MakeBackups ),     // Retrieve backup status
      Ext       = 0,                        // Ext counter
      savBuff,                              // Edit buffer id
      newFile                               // Eork buffer id


   if not DoBackups                         // if backups are disabled
      if IsChanged()                        //  If the file has been changed
         return( SaveFile() )               //   save it and go home
      else
         Message( "No changes pending, save request ignored." )
      endif
   else
      Toggle( MakeBackups )                 // Turn backups off
   endif

   if IsChanged()                           // No backup if file hasn't changed
      //
      //  Check to see if this a local extension
      //
      BackUpDir = iif( Pos( TExt, LocalExt ) <> 0, LocalDir, GlobalDir )

      //
      //  If the backup dir does not exist create it
      //
      if not FileExists( BackUpDir + "*.*" ) and Pos( TExt, NoBackUp ) == 0
         Dos( "MkDir " + BackUpDir, _DONT_CLEAR_ | _DONT_PROMPT_)
      endif

      //
      // Let's see if this is one we want to do an incremental on
      //
      if Pos( TExt, IncExt ) <> 0
         //
         // We'll loop till we find an unused ext
         //
         repeat
            FExt  = Format( Str( Ext ):3:"0" )
            TName = BackUpDir + FName + "." + FExt
            Ext   = Ext + 1
         until not FileExists( TName )

      elseif Pos( TExt, NoBackUp ) <> 0
         //
         //  This ext is flaged for _no_ backups
         //
         TName = ""

      else
         //
         //  We'll just do an ordinary BU
         //
         //  Get the standard BU ext and build the filename
         //
         TName = BackUpDir + FName + FExt

      endif

      //
      //  It's necessary to reload the original from disk to do a proper
      //  backup.  Simply saving the currently loaded file only creates
      //  a duplicate of the edited file, not a copy prior to editing.
      //  All of this is a bit in-elegant but I don't see any other way
      //  to do it.  The one caveat is when you are editing a large file
      //  the reload can take a few seconds in this case.
      //

      //
      // If a temp name has been created and the file already exists
      // on disk (not a new file) then process the backup
      //
      if Length( TName ) and FileExists( CurrFileName() )
         savName = CurrFileName()           // Save the current filename

         savBuff = GetBufferID()            // Save the current buffer
         newFile = CreateTempBuffer()       // Create a work buffer

         GoToBufferID( newFile )            // Go to the work buffer
         InsertFile( savName )              // Load the original file

         SaveAs( TName, _OVERWRITE_ )       // Save the work file w/inc name
                                            // We use SaveAs since normal backup
                                            //   processing is disabled

         AbandonFile( newFile )             // Abandon the work file
         GoToBufferID( savBuff )            // Return to original buffer
      endif

      retVal = SaveFile()                   // Save the original

      if retVal
         Message( "Save successful." )      // Tell user it went OK
      else
         Message( "Save failed.  Return code = " + Str( retVal ))
      endif
   else
      Message( "No changes pending, save request ignored." )
   endif

   //
   //  Turn internal BU processing back on and go home
   //
   Set( MakeBackups, DoBackups )
   return( retVal )
end  mSaveFile


integer proc mSaveAndQuitFile()
   integer retVal

   retVal = mSaveFile()
   AbandonFile()

   return( retVal )
end  mSaveAndQuitFile


integer proc mSaveAllFiles()
   integer
      retVal = FALSE,
      start  = GetBufferID()

   repeat
      if ( Query( BufferType ) == _NORMAL_ )
         retVal = mSaveFile()
      endif

      NextFile()
   until ( GetBufferID() == start )

   return( retVal )
end  mSaveAllFiles


proc mSaveAllAndExit()
   integer
      start  = GetBufferID()

   repeat
      if ( Query( BufferType ) == _NORMAL_ )
         mSaveFile()
      endif

      NextFile()
   until ( GetBufferID() == start )

   AbandonEditor()
end  mSaveAllAndExit


Menu QuitMenu()
   title = "File Changes"

   "&Yes, Save Changes"       ,   mSaveAndQuitFile()
   "&No, Abandon Changes"     ,   AbandonFile()
   "&OOPs, Wrong Key"
end


proc mQuitFile()
   if IsChanged()
      QuitMenu()
   else
      AbandonFile()
   endif
end  mQuitFile



