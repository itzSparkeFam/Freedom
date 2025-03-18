if Config.AutoInsertSQL then
    function InsertSQL()
        local Result = DatabaseQuery('SELECT 1 FROM cd_dispatch')
        if not Result then
            print('^5----------------------------^0')
            print('^5Automatically Inserting SQL.^0')
            print('^5----------------------------^0')
            DatabaseQuery('CREATE TABLE `cd_dispatch` (`identifier` VARCHAR(50) NULL DEFAULT NULL, `callsign` VARCHAR(100) NULL DEFAULT NULL);')
            print('^5--------------------------^0')
            print('^5SQL Inserted Successfully.^0')
            print('^5--------------------------^0')
        end
    end
end