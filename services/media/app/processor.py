import httpx, asyncio, uuid
from pathlib import Path
DOWNLOAD_DIR = Path('/tmp/trackpose_media'); DOWNLOAD_DIR.mkdir(parents=True, exist_ok=True)
async def download_file(url,dest:Path):
    async with httpx.AsyncClient() as c:
        r=await c.get(url); r.raise_for_status(); dest.write_bytes(r.content)
async def run_mediapipe_processing(local_path:Path):
    await asyncio.sleep(1)
    return {"emotion_summary":{"dominant":"happy","distribution":{"happy":0.75,"sad":0.1,"neutral":0.15},"examples":[]},"activity_summary":{"active_minutes":30,"sedentary_minutes":10,"events":[]},"wellbeing_score":82,"events":[]}
async def process_file_async(file_url, callback_url, metadata):
    job_id = str(uuid.uuid4())
    try:
        local = DOWNLOAD_DIR / f"{job_id}.bin"
        await download_file(file_url, local)
        result = await run_mediapipe_processing(local)
        payload = {"job_id": job_id, "file_url": file_url, "metadata": metadata, "result": result}
        async with httpx.AsyncClient() as c:
            await c.post(callback_url, json=payload)
    except Exception as e:
        print('processing error', e)
