# Fertilizer Management for Global Ammonia Emission Reduction
## Model Card – NH<sub>3</sub> emission factors from cropland
### Model Details
• The global cropland NH<sub>3</sub> emission factors regressor provided by this work, is trained to estimate the NH3 emission factors during crop growth season based on various factors, such as climate, soil characteristics, crop types, irrigation water, and fertilization and tillage practices.<br>
• Ensemble of 100 random forest regressors.<br>
• Developed by researchers at HKUST and SUSTech in 2023.
### Intended Use
• Intended to be used for promoting sustainable agriculture, such as fertilizer management, emission control, and supporting policy making.<br>
• Intended to be used for further research in earth and environmental sciences.<br>
• Not intended to estimate the emission factors for crops other than rice, wheat, and maize.
### Factors
• Relevant factors include climate, soil characteristics, crop types, irrigation water, and fertilization and tillage practices.
### Metrics
• The coefficient of determination and root mean square error, which measure the difference between observations and model predictions, are reported. 
### Training Data
• 80% of data in the dataset this work collected.
### Evaluation Data
• 20% of data in the dataset this work collected.
### Ethical considerations
• The model provides compelling evidence of the efficacy of AI-aided fertilizer management system in reducing NH<sub>3</sub> emissions without altering total nitrogen fertilizer inputs.
### Caveats and Recommendations
• Due to data availability, some possible relevant factors, such as particular types of enhanced-efficiency fertilizers and manure, irrigation techniques, the timing of precipitation and fertilizer incorporation depths, were not considered. Future research may consider improving this.
### Quantitative Analyses
• Shown in the original paper.
