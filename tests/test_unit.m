cwd = fileparts(mfilename('fullpath'));
run(fullfile(cwd, '../setup.m'))
%% md5sum
hash = md5sum(fullfile(fileparts(mfilename('fullpath')), 'gemini3d_url.ini'));
if ~isempty(hash)
  assert(strcmp(hash, 'b5f96c19e312374a5f9839410d681514'), 'md5sum %s', hash)
end
%% is_file
assert(is_file(fullfile(cwd, '../setup.m')), 'is_file true')
assert(~is_file('~'), 'is_file false')
%% is_folder
assert(is_folder(fullfile(cwd, '..')), 'is_folder true')
assert(is_folder('~'), 'is_folder expandued')
%% expanduser
pexp = expanduser('~/foo');
assert(~strcmp(pexp(1), '~'), 'expanduser')
%% is_absolute_path
% path need not exist
assert(is_absolute_path('~/foo'), 'expand and resolve')
%% absolute_path
pabs = absolute_path('2foo');
pabs2 = absolute_path('4foo');
assert(~strcmp(pabs(1), '2'), 'absolute_path')
assert(strcmp(pabs(1:2), pabs2(1:2)), 'absolute_path 2 files')
%% with_suffix
assert(strcmp(with_suffix('foo.h5', '.nc'), 'foo.nc'), 'with_suffix switch')
%% dateinc
[ymd, utsec] = dateinc(0.5, [2012,3,27], 1500);
assert(all(ymd == [2012, 3, 27]))
assert(utsec == 1500.5)
%% max mpi
assert(max_mpi([48,1,40], 5) == 5, 'max_mpi fail 5 cpu')
assert(max_mpi([48,40,1], 5) == 5, 'max_mpi fail 5 cpu')
assert(max_mpi([48,1,40], 6) == 5, 'max_mpi fail 6 cpu')
assert(max_mpi([48,40,1], 6) == 5, 'max_mpi fail 6 cpu')
assert(max_mpi([48,1,40], 8) == 8, 'max_mpi fail 8 cpu')
assert(max_mpi([48,40,1], 8) == 8, 'max_mpi fail 8 cpu')
assert(max_mpi([48,1,40], 28) == 20, 'max_mpi fail 28 cpu')
assert(max_mpi([48,1,40], 28) == 20, 'max_mpi fail 28 cpu')
assert(max_mpi([48,1,36], 28) == 18, 'max_mpi fail 28 cpu')
%% MSIS setup
cfg = struct('ymd', [2015,1,2], 'UTsec0', 43200, 'f107', 100.0, 'f107a', 100.0, 'Ap', 4);
lx = [4, 2, 3];
[glon, alt, glat] = meshgrid(linspace(-147, -145, lx(2)), linspace(100e3, 200e3, lx(1)), linspace(65, 66, lx(3)));
xg = struct('glat', glat, 'glon', glon, 'lx', lx, 'alt', alt);
atmos = msis_matlab3D(cfg, xg);
assert(all(size(atmos) == [lx(1), lx(2), lx(3), 7]), 'MSIS setup data output shape unexpected')
