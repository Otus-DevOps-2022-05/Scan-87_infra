variable cloud_id{
  description = "Cloud"
  default = "bpe"
}
variable folder_id {
  description = "Folder"
  default = "b9m"
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
  default = "fa5"
}
variable subnet_id{
  description = "Subnet id"
  default = "en"
}
variable service_account_key_file{
  description = "Service account key" 
  default = "/***/key.json"
}
