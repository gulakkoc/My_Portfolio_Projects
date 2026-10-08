from dotenv import load_dotenv
import streamlit as st
from langchain_groq import ChatGroq


#load the env variables

load_dotenv()

#streamlit page setup

st.set_page_config( 
    
    page_title= "Chatbot",
    page_icon="🤖",
    layout="centered"
)
st.title("💬 Gulfaden's Chatbot")


#chat_history = []

#user_prompt = st.chat_input("Ask Chatbot...")

#initiate chat history

if "chat_history" not in st.session_state :
    st.session_state.chat_history = []
    
    
#show chat history

for message in st.session_state.chat_history:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])
        
        

# llm initiate

llm = ChatGroq(model = "openai/gpt-oss-120b", temperature = 0)
        
    
user_prompt = st.chat_input("Ask Chatbot...")


if user_prompt :
    st.chat_message("user").markdown(user_prompt)
    
    st.session_state.chat_history.append({"role" : "user", "content" : user_prompt})
    
    response = llm.invoke(
        
        input = [{"role": "system", "content": """You are Gulfaden's AI chatbot, created by Gulfaden Akkoc.
            You are a friendly, helpful, and professional assistant.
            If someone asks who you are or who created you,
            introduce yourself as Gulfaden's AI chatbot.
            If asked about your underlying AI model, answer honestly."""}, *st.session_state.chat_history]
    )

    assistant_response = response.content
    st.session_state.chat_history.append({"role" : "assistant", "content" : assistant_response})


    with st.chat_message("assistant"):
        st.markdown(assistant_response)
        
        
        
        
###[
    #{"role" : "assistant", "content" : "What is ML?"}
    
###]
