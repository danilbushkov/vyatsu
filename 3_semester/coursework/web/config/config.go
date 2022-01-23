package config

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"os"
)

const fileConfig = "config.json"

var Config *TConfig

type TConfig struct {
	DB DBconfig `json:"db"`
}

type DBconfig struct {
	User     string `json:"user"`
	Password string `json:"password"`
	Port     string `json:"port"`
	DBname   string `json:"dbname"`
	Host     string `json:"host"`
}

func InitConfig() *TConfig {

	filename, err := os.Open(fileConfig)
	if err != nil {
		log.Fatal(err)
	}
	defer filename.Close()

	data, err := ioutil.ReadAll(filename)
	if err != nil {
		log.Fatal(err)
	}

	var config *TConfig

	err = json.Unmarshal(data, &config)

	if err != nil {
		log.Fatal(err)
	}

	return config

}
