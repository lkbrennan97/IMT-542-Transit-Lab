import camelot
import pandas as pd
import os

def extract_schedule(pdf_path):
    # Extract tables using Lattice flavor for grid-based schedules
    tables = camelot.read_pdf(pdf_path, pages='all', flavor='lattice')
    
    df_list = []
    for table in tables:
        df = table.df
        # Programmatic "Forward-Fill" for merged cells
        df = df.replace('', pd.NA).ffill()
        df_list.append(df)
    
    final_df = pd.concat(df_list)
    output_path = os.path.join('data', 'cleaned_schedule.csv')
    final_df.to_csv(output_path, index=False)
    print(f"Extraction complete: {output_path}")

if __name__ == "__main__":
    # Update this to your actual PDF filename
    extract_schedule('data/input_schedule.pdf')
