% test basic functions

cwd = fileparts(mfilename('fullpath'));
run(fullfile(cwd, '../setup.m'))

try %#ok<TRYNC>
  pkg('load', 'netcdf')
end
%% setup
if exist('checkcode', 'file')
  checkcode_recursive(fullfile(cwd, '..'))
else
  fprintf(2, 'SKIP: checkcode\n');
end

tic
%% config.nml unit test
p = read_config(fullfile(cwd, 'test2dew_fang', 'config.nml'));
assert(p.xdist == 200000)
q = read_config(fullfile(cwd, 'test2dew_fang'));
assert(isequaln(p, q), 'file or folder should give same result')
%% dateinc unit test
[ymd, utsec] = dateinc(0.5, [2012,3,27], 1500);
assert(all(ymd == [2012, 3, 27]))
assert(utsec == 1500.5)
%% max mpi unit test
assert(max_mpi([48,1,40], 5) == 5, 'max_mpi fail 5 cpu')
assert(max_mpi([48,40,1], 5) == 5, 'max_mpi fail 5 cpu')
assert(max_mpi([48,1,40], 6) == 5, 'max_mpi fail 6 cpu')
assert(max_mpi([48,40,1], 6) == 5, 'max_mpi fail 6 cpu')
assert(max_mpi([48,1,40], 8) == 8, 'max_mpi fail 8 cpu')
assert(max_mpi([48,40,1], 8) == 8, 'max_mpi fail 8 cpu')
assert(max_mpi([48,1,40], 28) == 20, 'max_mpi fail 28 cpu')
assert(max_mpi([48,1,40], 28) == 20, 'max_mpi fail 28 cpu')
assert(max_mpi([48,1,36], 28) == 18, 'max_mpi fail 28 cpu')
%% test2dew_eq_hdf5
runner('test2dew_eq_h5')
%% test2dew_eq_nc4
runner('test2dew_eq_nc')
%% test2dew_fang_h5
runner('test2dew_fang_h5')
%% test2dew_fang_nc
runner('test2dew_fang_nc')
%% test2dew_glow_h5
runner('test2dew_glow_h5')
%% test2dew_glow_nc
runner('test2dew_glow_nc')

%% test3d_eq_hdf5
runner('test3d_eq_h5')
%% test3d_eq_nc4
runner('test3d_eq_nc')
%% test3d_fang_h5
runner('test3d_fang_h5')
%% test3d_fang_nc
runner('test3d_fang_nc')
%% test3d_glow_h5
runner('test3d_glow_h5')
%% test3d_glow_nc
runner('test3d_glow_nc')
% done
toc
disp('OK: gemini-matlab')
