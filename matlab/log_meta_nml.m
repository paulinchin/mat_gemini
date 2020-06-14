function log_meta_nml(meta, filename)

narginchk(2,2)
validateattributes(meta, {'struct'}, {'scalar'},1)
validateattributes(filename, {'char'}, {'vector'},2)

fid = fopen(filename, 'w');
if fid < 1
  error('log_meta_nml:os_error', 'could not create file %s', filename)
end

fprintf(fid, '%s\n', '&setup_meta');

% variable string values get quoted per NML standard
fprintf(fid, 'matlab_version = "%s"\n', version());

fprintf(fid, 'git_version = "%s"\n', meta.git_version);
fprintf(fid, 'git_remote = "%s"\n', meta.remote);
fprintf(fid, 'git_branch = "%s"\n', meta.branch);
fprintf(fid, 'git_commit = "%s"\n', meta.commit);
fprintf(fid, 'git_porcelain = "%s"\n', meta.porcelain);

fprintf(fid, '%s\n', '/');
fclose(fid);

end %function
