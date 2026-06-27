import streamlit as st
import pandas as pd

st.set_page_config(
    page_title="CVD.AI",
    page_icon="❤️",
    layout="centered"
)

st.title("❤️ CVD.AI")
st.caption("AI-powered ECG risk monitoring demo by PulseGuard AI")

st.warning(
    "This is a hackathon prototype. The result is not a medical diagnosis. "
    "Please consult a healthcare professional."
)

st.markdown("## 1. Personal Information")

name = st.text_input("Full Name", value="Fayzeh")
age = st.number_input("Age", min_value=1, max_value=120, value=21)
gender = st.selectbox("Gender", ["Female", "Male", "Other"])
phone = st.text_input("Phone Number", value="0590000000")
emergency_name = st.text_input("Emergency Contact Name", value="Leen")
emergency_phone = st.text_input("Emergency Contact Phone", value="0591111111")

st.markdown("---")
st.markdown("## 2. Medical Risk Factors")

medical_weights = {
    "Family history of heart disease": 8,
    "Smoking": 8,
    "Diabetes": 10,
    "High blood pressure": 10,
    "Previous heart disease": 12,
    "High cholesterol": 7,
    "Obesity": 5,
    "Chronic stress": 5,
    "Low physical activity": 5,
    "Age above 60": 10,
}

selected_medical_factors = []

for factor, weight in medical_weights.items():
    checked = st.checkbox(f"{factor} (+{weight})")
    if checked:
        selected_medical_factors.append(factor)

medical_score = sum(medical_weights[f] for f in selected_medical_factors)

if age >= 60 and "Age above 60" not in selected_medical_factors:
    medical_score += 10

medical_score = min(medical_score, 100)

st.info(f"Medical Factor Score: {medical_score}/100")

st.markdown("---")
st.markdown("## 3. Symptoms")

symptom_weights = {
    "Chest pain": 20,
    "Shortness of breath": 15,
    "Palpitations": 12,
    "Sweating": 8,
    "Dizziness": 8,
    "Fatigue": 5,
    "Nausea": 5,
}

no_symptoms = st.checkbox("No symptoms")

selected_symptoms = []

if not no_symptoms:
    for symptom, weight in symptom_weights.items():
        checked = st.checkbox(f"{symptom} (+{weight})")
        if checked:
            selected_symptoms.append(symptom)

symptoms_score = sum(symptom_weights[s] for s in selected_symptoms)
symptoms_score = min(symptoms_score, 100)

user_profile_score = min(medical_score + symptoms_score, 100)

st.info(f"Symptoms Score: {symptoms_score}/100")
st.success(f"User Profile Score: {user_profile_score}/100")

st.markdown("---")
st.markdown("## 4. ECG Analysis Demo")

scenario = st.selectbox(
    "Choose demo ECG sample",
    ["Normal ECG", "Irregular ECG", "High Risk ECG"]
)

def get_ecg_result(selected_scenario):
    if selected_scenario == "Normal ECG":
        return {
            "ecg_ai_score": 18,
            "heart_rate": 76,
            "rhythm": "Regular",
            "prediction": "Normal",
            "signal_quality": "Good",
            "waveform": [0, 0.1, 0.2, 0.1, 0, -0.1, 0.1, 1.0, -0.5, 0.2, 0.1, 0]
        }

    if selected_scenario == "Irregular ECG":
        return {
            "ecg_ai_score": 55,
            "heart_rate": 102,
            "rhythm": "Irregular",
            "prediction": "Abnormal Rhythm",
            "signal_quality": "Good",
            "waveform": [0, 0.2, -0.1, 0.1, 0.3, -0.2, 0.2, 1.1, -0.6, 0.3, 0.1, -0.1]
        }

    return {
        "ecg_ai_score": 88,
        "heart_rate": 124,
        "rhythm": "Irregular",
        "prediction": "High Risk Pattern",
        "signal_quality": "Good",
        "waveform": [0, 0.3, -0.2, 0.2, 0.5, -0.3, 0.3, 1.4, -0.8, 0.4, 0.2, -0.2]
    }

ecg_result = get_ecg_result(scenario)

waveform_df = pd.DataFrame({
    "ECG Signal": ecg_result["waveform"]
})

st.line_chart(waveform_df)

st.write(f"**Prediction:** {ecg_result['prediction']}")
st.write(f"**Heart Rate:** {ecg_result['heart_rate']} bpm")
st.write(f"**Rhythm:** {ecg_result['rhythm']}")
st.write(f"**Signal Quality:** {ecg_result['signal_quality']}")
st.write(f"**ECG AI Score:** {ecg_result['ecg_ai_score']}/100")

st.markdown("---")
st.markdown("## 5. Final Risk Result")

final_score = (ecg_result["ecg_ai_score"] * 0.70) + (user_profile_score * 0.30)

if final_score <= 30:
    risk_level = "Low Risk"
    recommendation = "No major abnormal pattern was detected in this ECG sample. Continue monitoring."
elif final_score <= 60:
    risk_level = "Medium Risk"
    recommendation = "Some risk indicators were detected. Medical review is recommended."
else:
    risk_level = "High Risk"
    recommendation = "High-risk ECG pattern and/or symptoms were detected. Urgent medical review is recommended."

col1, col2, col3 = st.columns(3)

col1.metric("ECG AI Score", f"{ecg_result['ecg_ai_score']}/100", "70% weight")
col2.metric("User Profile Score", f"{user_profile_score}/100", "30% weight")
col3.metric("Final Risk Score", f"{final_score:.1f}/100", risk_level)

if risk_level == "Low Risk":
    st.success(f"### {risk_level}")
elif risk_level == "Medium Risk":
    st.warning(f"### {risk_level}")
else:
    st.error(f"### {risk_level}")

st.write(recommendation)

if risk_level == "High Risk":
    if st.button("Notify Caregiver"):
        st.success(
            f"Caregiver alert sent to {emergency_name} at {emergency_phone}. "
            "Demo only — no real SMS was sent."
        )

st.markdown("---")
st.markdown("### Technical Formula")
st.code(
    f"Final Risk Score = ({ecg_result['ecg_ai_score']} × 0.70) + ({user_profile_score} × 0.30) = {final_score:.1f}"
)

st.markdown("### Selected Inputs")

summary_data = {
    "Name": name,
    "Age": age,
    "Gender": gender,
    "Medical Factors": ", ".join(selected_medical_factors) if selected_medical_factors else "None",
    "Symptoms": ", ".join(selected_symptoms) if selected_symptoms else "None",
    "ECG Scenario": scenario,
    "Risk Level": risk_level,
}

st.json(summary_data)
