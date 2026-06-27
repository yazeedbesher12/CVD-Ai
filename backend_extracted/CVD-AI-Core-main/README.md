# CVD-AI-Core
Predictive cardiac monitoring algorithm - ISEF 2024 Research.

🩺 Overview

CVD.ai is an AI-powered cardiac monitoring system designed to detect early indicators of myocardial infarction (heart attack) from ECG signals.

The project earned 🥈 2nd Place at the International Science and Engineering Fair (ISEF) 2024.

Instead of reacting after symptoms appear, the system focuses on proactive prevention by identifying subtle changes in heart rhythms and providing a ~15 minute early warning window.

🚀 Technical Pipeline

The system processes electrical heart signals using a three-stage clinical pipeline designed for reliability and accuracy.


1️⃣ Signal Preprocessing & Denoising

Raw ECG signals contain noise from muscles, sensors, and electrical interference.
Our preprocessing pipeline isolates the true cardiac signal.

Techniques used

Median Filtering

Removes baseline wander and motion artifacts

Butterworth Low-pass Filter

Eliminates high-frequency noise

Wavelet Transform

Isolates the P–Q–R–S–T complex

Enables precise feature extraction


2️⃣ Clinical Feature Engineering

The algorithm extracts 19 biometric features commonly used in cardiology diagnostics.

Key feature groups

Feature Category	Description
HRV (Heart Rate Variability)	RR-interval standard deviation
Morphological Features	R-peak amplitude & T-wave characteristics
Interval Timings	QRS duration & localized heart rate metrics

These features provide a clinically meaningful representation of cardiac activity.


3️⃣ Deep Learning Architecture

The core prediction model is a Long Short-Term Memory (LSTM) neural network.

Unlike traditional models, LSTMs learn temporal dependencies in sequential ECG signals, allowing detection of:

subtle rhythm shifts

evolving cardiac stress

early infarction indicators

This enables the system to predict potential cardiac events before they fully manifest.


📊 Performance & Diagnostics

The model is evaluated using strict research-grade metrics.

| Metric                  | Score    |
| ----------------------- | -------- |
| **Accuracy**            | **93%**  |
| **Macro Average F1**    | **0.93** |
| **Weighted Average F1** | **0.93** |
| **Total Samples**       | **1000** |

Interpretation

High Recall (0.93) ensures the model detects most true cardiac risk cases.

High Precision (0.95) minimizes false alarms.

Balanced F1 Score (0.94) indicates stable performance across both classes.

This balance is crucial in medical diagnostics, where missing a true positive could lead to severe patient outcomes.


🧠 Key Technologies

Python

NumPy

SciPy

TensorFlow

TensorFlow Lite

Signal Processing

Wavelet Analysis

LSTM Deep Learning

🎯 Vision

Our goal is to shift cardiac medicine from:

Reactive Treatment → Predictive Prevention

By integrating AI + wearable ECG monitoring, CVD.ai aims to provide continuous cardiac risk assessment and early alerts for patients worldwide.
