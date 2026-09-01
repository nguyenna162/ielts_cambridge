import os
import sys
from pathlib import Path
from pydantic_settings import BaseSettings, SettingsConfigDict


def get_env_file_path() -> str:
    # If running as PyInstaller frozen exe
    if getattr(sys, "frozen", False):
        exe_dir = Path(sys.executable).resolve().parent
        candidate = exe_dir / ".env"
        if candidate.exists():
            return str(candidate)
        # Also check current working directory
        cwd_candidate = Path.cwd() / ".env"
        if cwd_candidate.exists():
            return str(cwd_candidate)

    # In regular dev mode
    dev_env = Path(__file__).resolve().parent.parent / ".env"
    if dev_env.exists():
        return str(dev_env)

    return ".env"


class Settings(BaseSettings):
    DATABASE_URL: str = "postgresql+psycopg://admin:1@localhost:5432/Cambridge_ielts"
    SECRET_KEY: str = "dev_secret_key_ielts_app_change_in_production"
    CONTENT_DIR: str = "../content"
    STATIC_DIR: str = "app/static"
    PORT: int = 8000
    HOST: str = "0.0.0.0"

    model_config = SettingsConfigDict(
        env_file=get_env_file_path(),
        env_file_encoding="utf-8",
        extra="ignore",
    )


settings = Settings()
