function exe = get_gemini_exe(exe)
arguments
  exe string = fullfile(getenv("GEMINI_ROOT"), "build/gemini.bin")
end

exe = gemini3d.sys.gemini_exe_name(exe);

if ~isfile(exe)
  gemini3d.sys.build_gemini3d(fullfile(fileparts(exe), ".."), exe);
end
assert(isfile(exe), 'failed to build ' + exe)
%% sanity check gemini.bin executable
prepend = gemini3d.sys.modify_path();
[ret, msg] = system(prepend + " " + exe);

if ret ~= 0
  error("get_gemini_exe:runtime_error", "problem with Gemini.bin executable: %s  error: %s", exe, msg)
end

end % function
