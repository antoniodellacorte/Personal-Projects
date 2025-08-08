MIMIC-IV Comorbidity Prediction Pipeline
This repository contains a comprehensive machine learning pipeline designed to predict the presence of diabetes and cardiovascular diseases (CVD) using the MIMIC-IV (Medical Information Mart for Intensive Care IV) dataset. The pipeline encompasses data loading, exploratory data analysis (EDA), preprocessing, feature engineering, model training (traditional and Multi-Task Learning neural networks), and thorough evaluation, including SHAP interpretability.

Table of Contents
Project Overview

Features

Dataset

Installation

Usage

Project Structure

Results and Visualizations

Future Work

Contributing

License

Contact

Project Overview
The goal of this project is to develop and evaluate predictive models for two significant comorbidities: diabetes and cardiovascular disease, leveraging the rich clinical data available in the MIMIC-IV database. The pipeline is built to be robust, reproducible, and interpretable, providing insights into feature importance and model behavior.

Features
Data Loading: Efficiently loads various tables from the MIMIC-IV dataset, with optimized column selection for large files.

Exploratory Data Analysis (EDA): Performs comprehensive EDA, generating visualizations for data distributions, missing values, and initial relationships.

Data Preprocessing & Cleaning: Handles missing values, cleans and standardizes data, and converts relevant columns to appropriate types.

Feature Engineering: Creates derived features from lab events and prescriptions, including temporal filtering to ensure events occur before admission.

Comorbidity Labeling: Identifies diabetes and CVD cases based on ICD-9 and ICD-10 diagnosis codes.

Unified Feature Matrix: Merges demographic, admission, lab, and prescription data into a single, comprehensive feature set.

Advanced Imputation: Utilizes a Feedforward Neural Network (FFNN) for imputing missing numerical values, alongside missing indicators.

Model Training:

Traditional Models: Trains and evaluates Logistic Regression, Random Forest, and XGBoost classifiers.

Deep Learning Multi-Task Learning (MTL) Model: Implements a custom Keras MTL model with shared layers for predicting both diabetes and CVD simultaneously, incorporating weighted binary cross-entropy loss for class imbalance.

Model Evaluation: Generates detailed classification reports, confusion matrices, ROC curves, and Precision-Recall curves.

Cross-Validation: Performs K-Fold stratified cross-validation on the deep learning model to assess generalization.

Model Interpretability (SHAP): Provides SHAP (SHapley Additive exPlanations) plots to understand feature contributions for both deep learning and traditional models.

Logging: Comprehensive logging throughout the pipeline for tracking execution and debugging.

Dataset
This project utilizes the MIMIC-IV dataset, a freely accessible database comprising de-identified health-related data associated with stays of patients in critical care units.
Access to MIMIC-IV requires PhysioNet credentials and agreement to their data use terms.

Download: You must download the MIMIC-IV dataset (version 1.0 or later, specifically the hosp module) from PhysioNet.

Data Path: Configure the data_path variable in utils.py to point to the directory where you extract the hosp CSV files (e.g., C:/your/path/to/mimic-iv-1.0/hosp/ on Windows or /path/to/mimic-iv-1.0/hosp/ on Linux).

Installation
Clone the repository:

git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name

Create and activate the Conda environment:
This project uses a Conda environment for dependency management.

conda env create -f env.yml
conda activate ml_env

If you prefer pip, you can install dependencies from env.yml manually (or create a requirements.txt from it).

Download MIMIC-IV:
Ensure you have downloaded the MIMIC-IV hosp dataset and placed the CSV files in the specified data_path as mentioned in the Dataset section.

Usage
To run the full machine learning pipeline:

python main.py

The script will:

Load and preprocess the data.

Perform EDA and save plots to output/plots/eda/.

Train and evaluate various models.

Save model performance plots and SHAP explanations to output/plots/models/.

Save trained models to output/models/.

Log all pipeline execution details to output/logs/pipeline_execution.log.

Note on Memory Usage: The main.py script currently runs with sampling_fraction=1.0, meaning it attempts to use the full MIMIC-IV dataset. This requires significant RAM (potentially >32GB). If you encounter memory errors, consider adjusting the sampling_fraction in main.py (e.g., to 0.1 or 0.01 for initial testing) or running on a machine with more memory.

# In main.py, inside the if __name__ == "__main__": block
try:
    main(sampling_fraction=0.1) # Change 1.0 to a smaller fraction
except Exception as e:
    logger.critical(f"A critical error occurred outside the main pipeline function: {str(e)}", exc_info=True)

Project Structure
.
├── data_loader.py            # Handles dataset loading from CSV files.
├── eda.py                    # Contains functions for Exploratory Data Analysis and plotting.
├── env.yml                   # Conda environment file with all dependencies.
├── main.py                   # The main script to run the entire ML pipeline.
├── models.py                 # Defines the deep learning Multi-Task Learning (MTL) model and custom loss.
├── preprocessing.py          # Functions for data cleaning, feature engineering, and final dataset preparation.
├── training_evaluation.py    # Manages model training, evaluation, performance plotting, and SHAP explanations.
├── utils.py                  # Utility functions for common tasks (plotting, path determination, global metrics).
├── output/                   # Directory for all generated outputs (plots, models, logs).
│   ├── plots/
│   │   ├── eda/              # EDA visualizations
│   │   └── models/           # Model performance plots (ROC, PR, Confusion Matrices, SHAP)
│   ├── models/               # Saved Keras models
│   └── logs/                 # Detailed pipeline execution logs
└── README.md                 # This file.

Results and Visualizations
Upon successful execution, the output/plots directory will contain various visualizations:

EDA Plots: Histograms, bar charts, and correlation matrices providing insights into the raw data.

Model Performance Plots: Training history, confusion matrices, ROC curves, and Precision-Recall curves for all trained models.

SHAP Plots: Feature importance and contribution plots generated by SHAP for better model interpretability.

The console output and the pipeline_execution.log file will provide detailed metrics and reports for each model.

Future Work
Advanced Feature Engineering: Explore more complex temporal features, e.g., trends in lab values over time, or sequence modeling of medical events.

More Sophisticated Imputation: Investigate advanced imputation techniques like MICE (Multiple Imputation by Chained Equations) for comparison with FFNN.

Hyperparameter Tuning: Implement automated hyperparameter optimization (e.g., using Keras Tuner, Optuna, or GridSearchCV) for all models to maximize performance.

Explainable AI (XAI) Beyond SHAP: Integrate other XAI methods (e.g., LIME, saliency maps for deep models) to provide diverse perspectives on model decisions.

Deployment: Develop a simple web application or API to demonstrate model predictions.

Survival Analysis: Extend the project to predict time-to-event outcomes (e.g., time to diabetes onset, time to CVD event) using survival models.

Fairness and Bias Analysis: Evaluate models for potential biases across different demographic groups (e.g., age, gender, race) and implement debiasing strategies if necessary.

Different Cohorts/Tasks: Adapt the pipeline for other MIMIC-IV cohorts or different prediction tasks.

Contributing
Contributions are welcome! If you have suggestions for improvements, bug fixes, or new features, please open an issue or submit a pull request.

Contact
For any questions or inquiries, please contact [https://www.linkedin.com/in/antonio-della-corte-88a9ba259/].
