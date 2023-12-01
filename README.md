# AI-guided fertilizer management for global ammonia emission reduction
## Model Card – NH<sub>3</sub> emission factors from cropland
### Model Details
• The global cropland NH<sub>3</sub> emission factors regressor provided by this work, is trained to estimate the NH3 emission factors during crop growth season under various soil, weather, and human management conditions.<br>
• Ensemble of 100 random forest regressors.<br>
• Developed by researchers at HKUST and SUSTech in 2023.
### Intended Use
• Intended to be used for promoting sustainable agriculture, such as fertilizer management, emission control, and supporting policy making.<br>
• Intended to be used for further research in earth and environmental sciences.<br>
• Not intended to estimate the emission factors for crops other than rice, wheat, and maize.
### Factors
• Relevant factors include human management strategies, weather conditions, and soil properties.
### Metrics
• The coefficient of determination and root mean square error, which measure the difference between observations and model predictions, are reported. 
### Training Data
• 80% of data in the dataset this work collected.
### Evaluation Data
• 20% of data in the dataset this work collected.
### Ethical considerations
• The model only considers the impact of different variables on ammonia emissions, without taking into account the effects on crop yield.
### Caveats and Recommendations
• Due to data availability, some possible relevant factors, such as irrigation methods and fertilization depth, were not considered. Future research may consider improving this.
### Quantitative Analyses
• Shown in the original paper.
