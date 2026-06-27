# Project Overview

## Purpose

CVD.AI Mobile demonstrates an end-to-end cardiac risk screening experience. The app is designed for hackathon, research, or prototype presentation contexts where live smartwatch ECG input is not available.

## User Flow

1. User enters personal information.
2. User selects medical risk factors.
3. User selects symptoms.
4. App generates one simulated ECG sample for the assessment.
5. App shows a real-time animated ECG preview.
6. App calculates a weighted risk result.
7. User can export a hospital-style PDF report.

## Risk Model Used In The Demo

The final score is calculated as:

```text
Final Score = ECG AI Score * 0.70 + User Profile Score * 0.30
```

Risk levels:

- Low Risk: 0-30
- Medium Risk: 31-60
- High Risk: 61-100

## ECG Simulation

The app generates ECG-like waveforms using normal, irregular, and high-risk pattern parameters. This replaces smartwatch or sensor input for demo purposes.

The waveform is not a real patient signal.

## PDF Report

The exported report includes:

- Patient details
- Clinical risk classification
- ECG waveform image
- ECG analysis values
- Medical profile summary
- Clinical recommendation
- Medical disclaimer

