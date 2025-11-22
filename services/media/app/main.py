from fastapi import FastAPI
from pydantic import BaseModel
import asyncio
from .processor import process_file_async
app = FastAPI()
class Job(BaseModel):
    file_url: str
    callback_url: str
    metadata: dict = {}
@app.post('/api/process')
async def process(job: Job):
    asyncio.create_task(process_file_async(job.file_url, job.callback_url, job.metadata))
    return {"ok": True, "message": "Processing started (stub)"}
@app.get('/health')
def health():
    return {"ok": True}
