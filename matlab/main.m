if pyenv().Version == "" % cannot use isempty
    pyenv('Version', '/usr/bin/python3.10');
end

disp('Before:')
disp(py.sys.path)
modpaths = {fullfile(pwd, 'moduledir'), ...
            fullfile(pwd, '..', 'misc_modules')};
for k = 1:numel(modpaths)
    modpath = modpaths{k};

    %[st, res] = system(sprintf('rm -rf %s/__pycache__'));

    if count(py.sys.path, modpath) == 0
        %py.sys.path.insert(int32(0), modpath); % doesn't work
        insert(py.sys.path, int32(0), modpath);
    end
end
disp('After:')
disp(py.sys.path)

modnames = {'mymod', 'somemod'};
for k = 1:numel(modnames)
    modname = modnames{k};
    py.importlib.import_module(modname);
    py.(modname).run();
end
