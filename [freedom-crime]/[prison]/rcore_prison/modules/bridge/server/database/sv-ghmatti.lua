if Config.Database == Database.GHMATTI then
    MySQL = {
        Sync = {},
        Async = {},
        ready = function(cb)
            fprint('MySQL.ready is not supported by GHMattiMySQL', Levels.ERROR)
        end
    }

    function MySQL.Sync.fetchAll(query, table, cb)
        return exports[Database.GHMATTI]:executeSync(query, table, cb)
    end

    function MySQL.Sync.fetchScalar(query, table, cb)
        return exports[Database.GHMATTI]:scalar(query, table, cb)
    end

    function MySQL.Sync.execute(query, table, cb)
        return exports[Database.GHMATTI]:executeSync(query, table, cb)
    end

    function MySQL.Sync.insert(query, table, cb)
        return exports[Database.GHMATTI]:insert(query, table, cb)
    end

    function MySQL.Async.fetchAll(query, table, cb)
        return exports[Database.GHMATTI]:execute(query, table, cb)
    end

    function MySQL.Async.execute(query, table, cb)
        return exports[Database.GHMATTI]:execute(query, table, cb)
    end
end
