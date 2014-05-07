json.array! @camps do |camp|
    json.title camp.curriculum.name
    json.start camp.start_date
    json.end camp.end_date
end