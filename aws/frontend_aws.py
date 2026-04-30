import gradio as gr
from time import perf_counter
from aws.backend_aws import generate

def respond(
        message,
        history,
        sys_message,
        max_tokens,
        temp,
        top_p,
):

    payload = {
        "prompt": message,
        "system_message": sys_message,
        "max_tokens": max_tokens,
        "temp": temp,
        "top_p": top_p,
    }
        # post to appropriate server (local always works during development)
    #url = LOCAL_URL if use_local_model else BASE_URL
    response = generate(payload)
    response.raise_for_status()
    result = response.json()
    return result.get("response", f"No 'response' field returned: {result}")


chatbot = gr.ChatInterface(
    respond,
    additional_inputs=[
        gr.Textbox(value="You are a professional Songwriter and Lyricist." \
        " Your goal is to write lyrics that have a strong rhythm, clear structure, and creative rhymes.",
        label="System message"),
        gr.Slider(minimum=1, maximum=2048, value=512, step=1, label="Max new tokens"),
        gr.Slider(minimum=0.1, maximum=2.0, value=0.7, step=0.1, label="Temperature"),
        gr.Slider(minimum=0.1, maximum=1.0, value=0.95, step=0.05, label="Top-p (nucleus sampling)"),
        gr.Checkbox(label="Use Local Model", value=False),
    ]
)

with gr.Blocks() as demo:
    with gr.Row():
        gr.Markdown("<h1 style='text-align: center;'> 🎵 Song Generator Chatbot 🎵</h1>")
    chatbot.render()

demo.launch(server_name="0.0.0.0")
