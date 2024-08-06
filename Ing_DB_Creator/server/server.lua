ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('createdbtable', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getGroup() ~= 'admin' then
        TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = 'Du har ikke tilladelse til at bruge denne kommando.' })
        return
    end

    TriggerClientEvent('db_creator:openMenu', source)
end, false)

RegisterNetEvent('db_creator:createTable')
AddEventHandler('db_creator:createTable', function(tableName, columns)
    local source = source
    local columnDefs = {}
    for _, col in ipairs(columns) do
        table.insert(columnDefs, string.format("`%s` VARCHAR(255)", col))
    end

    local createTableQuery = string.format("CREATE TABLE IF NOT EXISTS `%s` (%s, `id` INT AUTO_INCREMENT PRIMARY KEY)", tableName, table.concat(columnDefs, ", "))

    MySQL.Async.execute(createTableQuery, {}, function(rowsChanged)
        if rowsChanged then
            TriggerClientEvent('ox_lib:notify', source, { type = 'success', description = string.format('Table %s Oprettet!', tableName) })
        else
            TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = 'Fejl ved oprettelse. Tjek Logs for fejlsøgning!' })
        end
    end)
end)
