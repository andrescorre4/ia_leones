import streamlit as st
import requests
import json
import os
from dotenv import load_dotenv
from datetime import datetime
import time

# Load environment variables
load_dotenv()

# Page configuration
st.set_page_config(
    page_title="OpenRouter Chat",
    page_icon="🤖",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Model configurations
MODELS = {
    "qwen/qwen2.5-vl-72b-instruct:free": {
        "name": "Qwen 2.5 VL 72B",
        "context": "131,072 tokens",
        "api_key": os.getenv("QWEN_API_KEY"),
        "description": "Advanced vision-language model"
    },
    "google/gemma-3-27b-it:free": {
        "name": "Gemma 3 27B",
        "context": "131,072 tokens", 
        "api_key": os.getenv("GEMMA_API_KEY"),
        "description": "Google's instruction-tuned model"
    },
    "deepseek/deepseek-r1-zero:free": {
        "name": "DeepSeek R1 Zero",
        "context": "163,840 tokens",
        "api_key": os.getenv("DEEPSEEK_API_KEY"),
        "description": "DeepSeek's reasoning model"
    }
}

# Initialize session state
if "messages" not in st.session_state:
    st.session_state.messages = []
if "selected_model" not in st.session_state:
    st.session_state.selected_model = "qwen/qwen2.5-vl-72b-instruct:free"

def get_api_key_for_model(model_id):
    """Get the appropriate API key for a model"""
    if model_id in MODELS and MODELS[model_id]["api_key"]:
        return MODELS[model_id]["api_key"]
    return os.getenv("DEFAULT_API_KEY")

def call_openrouter_api(model_id, messages, stream=False):
    """Call OpenRouter API with the specified model"""
    api_key = get_api_key_for_model(model_id)
    
    if not api_key:
        st.error(f"No API key configured for model: {model_id}")
        return None
    
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
        "HTTP-Referer": "https://github.com/josephgodwinkimani/openrouter-web",
        "X-Title": "OpenRouter Streamlit Chat"
    }
    
    payload = {
        "model": model_id,
        "messages": messages,
        "stream": stream,
        "temperature": st.session_state.get("temperature", 1.0),
        "max_tokens": st.session_state.get("max_tokens", 2048),
        "top_p": st.session_state.get("top_p", 1.0)
    }
    
    try:
        response = requests.post(
            f"{os.getenv('OPENROUTER_BASE_URL')}/chat/completions",
            headers=headers,
            json=payload,
            timeout=60
        )
        
        if response.status_code == 200:
            return response.json()
        else:
            st.error(f"API Error {response.status_code}: {response.text}")
            return None
            
    except requests.exceptions.RequestException as e:
        st.error(f"Request failed: {str(e)}")
        return None

def main():
    # Header
    st.title("🤖 OpenRouter Chat Application")
    st.markdown("---")
    
    # Sidebar for model selection and settings
    with st.sidebar:
        st.header("⚙️ Configuration")
        
        # Model selection
        st.subheader("🎯 Model Selection")
        model_options = {}
        for model_id, config in MODELS.items():
            display_name = f"{config['name']} ({config['context']})"
            model_options[display_name] = model_id
        
        selected_display = st.selectbox(
            "Choose a model:",
            options=list(model_options.keys()),
            index=0
        )
        st.session_state.selected_model = model_options[selected_display]
        
        # Show model info
        model_config = MODELS[st.session_state.selected_model]
        st.info(f"**{model_config['name']}**\n\n{model_config['description']}\n\nContext: {model_config['context']}")
        
        st.markdown("---")
        
        # Advanced settings
        st.subheader("🔧 Advanced Settings")
        
        st.session_state.temperature = st.slider(
            "Temperature",
            min_value=0.0,
            max_value=2.0,
            value=1.0,
            step=0.1,
            help="Controls randomness in responses"
        )
        
        st.session_state.max_tokens = st.slider(
            "Max Tokens",
            min_value=100,
            max_value=4000,
            value=2048,
            step=100,
            help="Maximum length of response"
        )
        
        st.session_state.top_p = st.slider(
            "Top P",
            min_value=0.0,
            max_value=1.0,
            value=1.0,
            step=0.1,
            help="Controls diversity of responses"
        )
        
        st.markdown("---")
        
        # Clear chat button
        if st.button("🗑️ Clear Chat", type="secondary"):
            st.session_state.messages = []
            st.rerun()
        
        # API Status
        st.subheader("📊 Status")
        api_key = get_api_key_for_model(st.session_state.selected_model)
        if api_key:
            st.success("✅ API Key Configured")
        else:
            st.error("❌ No API Key")
    
    # Main chat interface
    col1, col2 = st.columns([3, 1])
    
    with col1:
        # Display chat messages
        chat_container = st.container()
        
        with chat_container:
            for message in st.session_state.messages:
                with st.chat_message(message["role"]):
                    st.markdown(message["content"])
                    if "timestamp" in message:
                        st.caption(f"🕒 {message['timestamp']}")
        
        # Chat input
        if prompt := st.chat_input("Type your message here..."):
            # Add user message
            timestamp = datetime.now().strftime("%H:%M:%S")
            user_message = {
                "role": "user", 
                "content": prompt,
                "timestamp": timestamp
            }
            st.session_state.messages.append(user_message)
            
            # Display user message
            with st.chat_message("user"):
                st.markdown(prompt)
                st.caption(f"🕒 {timestamp}")
            
            # Get AI response
            with st.chat_message("assistant"):
                with st.spinner(f"Thinking with {MODELS[st.session_state.selected_model]['name']}..."):
                    # Prepare messages for API
                    api_messages = [{"role": msg["role"], "content": msg["content"]} 
                                  for msg in st.session_state.messages]
                    
                    # Call API
                    response = call_openrouter_api(
                        st.session_state.selected_model,
                        api_messages
                    )
                    
                    if response and "choices" in response:
                        assistant_content = response["choices"][0]["message"]["content"]
                        st.markdown(assistant_content)
                        
                        # Add assistant message to session state
                        assistant_timestamp = datetime.now().strftime("%H:%M:%S")
                        assistant_message = {
                            "role": "assistant",
                            "content": assistant_content,
                            "timestamp": assistant_timestamp
                        }
                        st.session_state.messages.append(assistant_message)
                        st.caption(f"🕒 {assistant_timestamp}")
                        
                        # Show usage info if available
                        if "usage" in response:
                            usage = response["usage"]
                            st.caption(f"📊 Tokens: {usage.get('total_tokens', 'N/A')} | Model: {MODELS[st.session_state.selected_model]['name']}")
                    else:
                        st.error("Failed to get response from the model. Please try again.")
    
    with col2:
        # Chat statistics
        st.subheader("📈 Chat Stats")
        
        total_messages = len(st.session_state.messages)
        user_messages = len([m for m in st.session_state.messages if m["role"] == "user"])
        assistant_messages = len([m for m in st.session_state.messages if m["role"] == "assistant"])
        
        st.metric("Total Messages", total_messages)
        st.metric("Your Messages", user_messages)
        st.metric("AI Responses", assistant_messages)
        
        # Current model info
        st.subheader("🎯 Current Model")
        current_model = MODELS[st.session_state.selected_model]
        st.write(f"**{current_model['name']}**")
        st.write(f"Context: {current_model['context']}")
        
        # Export chat
        if st.session_state.messages:
            st.subheader("💾 Export")
            if st.button("📄 Export as JSON"):
                chat_data = {
                    "model": st.session_state.selected_model,
                    "timestamp": datetime.now().isoformat(),
                    "messages": st.session_state.messages
                }
                st.download_button(
                    label="Download Chat",
                    data=json.dumps(chat_data, indent=2),
                    file_name=f"chat_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json",
                    mime="application/json"
                )

if __name__ == "__main__":
    main()
