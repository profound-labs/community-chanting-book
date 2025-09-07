import argparse
from parser_utils import tokenize, process_tokens

def process_file(input_file, output_file, heavy_end, use_x_below):
    try:
        with open(input_file, 'r', encoding='utf-8') as f_in,
             open(output_file, 'w', encoding='utf-8') as f_out:
            for line in f_in:
                tokens = tokenize(line.rstrip('\n'))
                processed_tokens = process_tokens(tokens, heavy_end, use_x_below)
                f_out.write("".join(processed_tokens) + '\n')
        print(f"Successfully processed {input_file} and saved to {output_file}")
    except FileNotFoundError:
        print(f"Error: Input file not found at {input_file}")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Process a text file with Pali phonetics.')
    parser.add_argument('input_file', help='The input file to process.')
    parser.add_argument('output_file', help='The output file to save the results.')
    parser.add_argument('--heavy-end', action='store_true', help='Use end heavy processing.')
    parser.add_argument('--x-below', action='store_true', help='Mark heavy end with x below.')

    args = parser.parse_args()

    process_file(args.input_file, args.output_file, args.heavy_end, args.x_below)
