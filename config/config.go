package config

import (
	"errors"
	"fmt"
	"os"
)

type Config struct {
	Port string
}

func New() (*Config, error) {
	port, err := getEnv("APP_PORT")
	if err != nil {
		return nil, err
	}

	return &Config{
		Port: port,
	}, nil
}

func getEnv(key string) (string, error) {
	if value, exists := os.LookupEnv(key); exists {
		return value, nil
	}

	return "", errors.New(fmt.Sprintf("Не удалось загрузить переменную окружения %v", key))
}
