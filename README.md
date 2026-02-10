# Supertails – E-commerce & Customer Analytics

## 📌 Overview
This project analyzes Supertails’ end-to-end e-commerce ecosystem across orders, communication logs, supply chain activity, support tickets, and vet consultations.

The objective is to evaluate operational efficiency, customer behavior, engagement effectiveness, and support outcomes using SQL and Python-driven analytics.

---

## 🧾 Dataset Summary
Multiple relational datasets were used:

| Dataset | Volume |
|---------|--------|
| Orders | ~10,000 |
| Communication Logs | ~40,000 |
| Supply Chain | ~10,000 |
| Support Tickets | ~5,000 |
| Vet Calls | ~5,000 |

**Validation Highlights**
- 100% date consistency across deliveries & resolutions  
- 100% foreign key integrity  
- ~6% supply scan anomalies flagged for review  

---

## 🛠 Tools & Technologies
- SQL  
- Python (Pandas, NumPy)  
- Data Cleaning & Validation  
- Exploratory Data Analysis  
- RFM Segmentation  
- Logistic Regression  

---

## 📊 Key Analysis Performed

### Revenue & Demand
- Category revenues were broadly diversified.
- Grooming led contribution; food lowest.
- All cities generated ₹2.5M+ with balanced distribution.

### Payment Behavior
- **75%+** revenue originated from digital modes, lowering cash-handling risks.

### Delivery Operations
- Turnaround time ranged between **1–7 days** with no extreme long-tail delays.

### Communication Effectiveness
- Engagement rates were tightly clustered across WhatsApp, Email, SMS, and Calls.
- Calls & WhatsApp slightly outperformed other channels.

---

## 👥 Customer Segmentation (RFM)
Customers were scored using Recency, Frequency, and Monetary value.

| Segment | Customers |
|---------|-----------|
| Bronze | 3,237 |
| New | 1,741 |
| Silver | 709 |
| Gold | 315 |

**Insight:**  
Gold customers are few but deliver the highest per-customer value, while revenue remains volume-driven by Bronze/New users.

---

## 🤖 Predictive Modeling – Support Ticket Likelihood
A logistic regression model was developed to predict whether a customer may raise a ticket.

**Performance:**
- Accuracy: ~0.68  
- F1: ~0.64  
- ROC-AUC: ~0.71  

**Business Use:**  
Enables proactive support planning and workload management.

---

## 💡 Business Recommendations
- Focus retention strategies on Bronze/New users.  
- Provide premium engagement for high-value Gold customers.  
- Continue promoting digital payments.  
- Maintain delivery SLAs given stable performance.

---

## 🚀 Skills Demonstrated
✔ SQL analytics  
✔ Multi-table data validation  
✔ KPI discovery  
✔ Customer segmentation  
✔ Predictive thinking  
✔ Business storytelling  

---

## 📬 Author
[GitHub](https://github.com/gxuxhxm)
