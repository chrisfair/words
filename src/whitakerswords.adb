-- This template is Public Domain.  Have fun.
--
-- You really ought to change this opening blurb to reflect your project
-- information.  One would expect, for example, that it would say something like
--     (C) Copyright 2015-05-08 by Christopher Fair
-- and give a quick blurb about how to use it and what it does.

-- This doesn't actually do anything, except respond to --verbose and --help,
-- and says hello world.

with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;

with confvars; -- Ada version of the environment ./configure set up.

procedure whitakerswords is

  -- options
  Verbose:    Boolean := false; -- Are we being verbose?
  Debug:      Boolean := false; -- Are we debugging?
  Silent:     Boolean := false; -- Are we being silent?
  Help:       Boolean := false; -- Do we need help?
  Version:    Boolean := false; -- Do we need a version?

  -- Anything files after the options?
  First_File: integer := 0;

  Problems: Boolean := false; -- Did this have junk?

begin

   -- -- Get the options.

   for I in 1 .. Argument_Count loop

      if    Argument (I) = "--verbose"
         or Argument (I) = "-v" then
         Verbose := True;
      elsif Argument (I) = "--silent"
         or Argument (I) = "--quiet"
         or Argument (I) = "-s" then
         Silent := True;
      elsif Argument (I) = "--debug" then
         Debug := True;
      elsif Argument (I) = "--help"
         or Argument (I) = "-h" then
         Help  := True;
      elsif Argument (I) = "--version" then
         Version := True;
      elsif Argument (I) = "--" then
	 if I < Argument_Count then
            First_File := I + 1;
	 end if;
         exit;
      elsif Argument (I)'Length > 0
            and then Argument (I) (1) = '-' then
         Put ("whitakerswords: Unknown argument "); Put (Argument (I)); New_Line;
         Problems := True;
      else -- OK, not an argument... lets assume it is a file.
         First_File := I;
         exit;
      end if;

   end loop;
   if First_File > Argument_Count then First_File := 0; end if;

   -- Bad arguments are fatal.
   if Problems then Set_Exit_Status (Failure); return; end if;


   -- -- Process argument related options.

   -- Echo out what we have.
   if Verbose or Debug then
      Put_Line ("whitakerswords called...");
      if Verbose then Put_Line ("  option: --verbose"); end if;
      if Debug   then Put_Line ("  option: --debug");   end if;
      if Silent  then Put_Line ("  option: --silent");  end if;
      if Version then Put_Line ("  option: --version"); end if;
      if Help    then Put_Line ("  option: --help");    end if;
      if First_File > 0 then
         for I in First_file .. Argument_Count loop
             Put ("    File: "); Put (Argument (I)); New_Line;
         end loop;
      end if;
      Put_Line ("... end of call echo");
      New_Line;
   end if;

   if Version then
      Put_Line ("whitakerswords Version 0.97");
   end if;

   if Help then
      Put_Line ("whitakerswords [options] [files]");
      Put_Line ("     --verbose    -v  blather on about everything.");
      Put_Line ("     --silent     -s  blather about nothing.");
      Put_Line ("     --help       -h  print this message.");
      Put_Line ("     --version        Program version.");
   end if;
   -- Help and version don't require running the program.
   if Help or Version then Set_Exit_Status (Success); return; end if;

   ------------------------------------------------------------------
   -- And actually do something.

   Put_Line ("Guts go here... (Hello there world)");
   Put      ("This is whitakerswords, and the GNU tools think the package is called ");
   Put_Line (confvars.PACKAGE_STRING);

   Set_Exit_Status (Success);

end whitakerswords;
