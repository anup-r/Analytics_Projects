1. EDA
1) There are 500 rows and 9 columns
2) Serial_No column is dropped from the data as it is not required for the analysis.
3) Non graphical analysis done to find unique elements and their value counts.
-From Univariate and bi-variate Analysis (Check Attachment for Graphs)
4) Checked for Normal Distribution of data using Distplot
5) Students who were into research or published research paper had more chances of admit compared to who did'nt publish research paper.
6) Most of the colleges are of University rating 2 & 3 ; Essential to select colleges where rating is 3 plus.
7) GRE Score,TOEFL Score is propotional to chance of admit, More the GRE Score/TOEFL Score more is the chance of getting into college with good rating.
8) CGPA is also a feature which affects the chance of admit as much as GRE,TOEFL Score.
9) Most of the features have values that are Normally Distributed.

2.Data Preprocessing.
1) Checked for Duplicate Values = 0.
2) There were no missing values.
3) Outlier was known using Boxplot and treated using IQR method.
4) Feature Engineering was performed on the data and was ready for data modeling.
5) Built Linear Regression Models using Linear Regression and Stats Model.

3. Model Building.
 1) GRE Score = 0.0421, TOEFL Score = 0.1326, Univ Rating = 0.0333, SOP = 0.0454, LOR = 0.0724, CGPA = 0.6937, Research = 0.0559 (Stats Model)
2) GRE Score = 0.1559784, TOEFL Score = 0.16280074, Univ Rating = 0.01913293, SOP = 0.01725867, LOR = 0.09839838, CGPA=0.57518939, Research = 0.03759617 (Linear Regression Model)
3)Research = 0.1693 , LOR = 0.4259 (VIF<5)
4) GRE Score = 0.1882,TOEFL Score = 0.1753,CGPA = 0.7058 (RFE and Stats Model)

4. Testing and assumptions:
1. VIF<5 model was based on filtering columns with less than vif<5 and made a model using it.
2.Standardization is done making the mean residuals nearly zero.
3. As the values are randomly distributed it follows Homoscedasticity.
4. All variables follow linear graph

5. Model Performance
1)Metrics
    a)MAE = 0.07173793, RMSE = 0.09885812 ,R2 = 0.8267235 (Linear Regression Model)
    b)MAE = 0.1187050, RMSE = 0.151312, R2= 0.503  ,Adj R2 = 0.500 (Stats and VIF <5)
    c)MAE = 0.073729, RMSE = 0.1039165, R2 = 0.811 , Adj R2 = 0.809   (RFE)
2)Train and Test Performance is checked.
3)Comments:
a)Linear Regression model gave a accuracy of 81.5 but P values are way above the limit and less coef values resulting multicollinearity.
b) After using VIF<5 and elliminating collinearity the accuracy of the model decreased to 50.30 so more room for improvement.
c) RFE model had a good accuracy of 81.1 slightly less than Linear Regression Model but had Pvalues least and Coef and highest making the effective model of choice.

6.Actionable Insights and Recommendations:
1)The predict values are as close as it can be as we are not counting outliers .
2)From the RFE model considering it as the benchmark we can say that most important features are CGPA,GRE Score, TOEFL Score having high coef.
3)LOR, SOP have are important but only when University rating is considered.
4)Students with less CGPA should try balancing it with SOP, LOR and low University Rating.
5) Students with all TOEFL, GRE, CGPA being in the top 10-15% can aim for 4plus rating of Universities with a good LOR and SOP.
