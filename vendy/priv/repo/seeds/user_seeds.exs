alias Vendy.CRM

%{"name" => "Tezt Uzer",
  "email" => "tezt@example.com",
  "password" => "password",
  "residence_area" => "Area 2",
  "phone" => "1111"
}
|> CRM.create_customer
