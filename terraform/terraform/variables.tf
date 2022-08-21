variable cloud_id{
  description = "Cloud"
  default = "b1gpe"
}
variable folder_id {
  description = "Folder"
  default = "b1gm"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable public_key_path {
  # Описание переменной
  description = "ssh public key"
  default = "/***/appuser.pub"
}
variable image_id {
  description = "Image id"
  default = "fda5"
}
variable subnet_id{
  description = "Subnet id"
  default = "e9pn"
}
variable service_account_key_file{
  description = "Service account key" 
  default = "/***/svc_keys/key.json"
}
