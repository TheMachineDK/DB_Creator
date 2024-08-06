RegisterNetEvent('db_creator:openMenu')
AddEventHandler('db_creator:openMenu', function()
    local dialog = {
        {
            type = 'input',
            label = 'Indtast Tabel navn:',
            name = 'table_name'
        },
        {
            type = 'number',
            label = 'Enter Number of Columns:',
            name = 'num_columns',
            min = 1,
            max = 10
        }
    }

    lib.inputDialog('Create Database Table', dialog, function(result)
        if result and result.table_name and result.num_columns then
            local columns = {}

            for i = 1, result.num_columns do
                local columnDialog = {
                    {
                        type = 'input',
                        label = string.format("Indtast Kulonne %d Navn:", i),
                        name = 'column_name'
                    }
                }

                local columnResult = lib.inputDialog('Indtast Kulonne Navn', columnDialog)
                if columnResult and columnResult.column_name then
                    table.insert(columns, columnResult.column_name)
                else
                    break
                end
            end

            if #columns == result.num_columns then
                TriggerServerEvent('db_creator:createTable', result.table_name, columns)
            else
                lib.notify({ type = 'error', description = 'Fejl ved oprettelse' })
            end
        else
            lib.notify({ type = 'error', description = 'Tabel oprettelse afbrudt eller fejl ved oprettelse' })
        end
    end)
end)
