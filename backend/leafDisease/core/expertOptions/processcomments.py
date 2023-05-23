import tensorflow as tf
import pickle
from tensorflow.keras.preprocessing.sequence import pad_sequences

# Load the saved model
model = tf.keras.models.load_model("core\\expertOptions\\commentAnalysis.h5")

with open("core\\expertOptions\\tokenizer.pickle", "rb") as handle:
    tokenizer = pickle.load(handle)

with open("core\\expertOptions\\max_len.pickle", "rb") as handle:
    max_len = pickle.load(handle)


# Preprocess new data
def preprocess_new_data(new_data):
    new_data = new_data.lower()
    new_data_tokens = tokenizer.texts_to_sequences([new_data])
    new_data_padded = pad_sequences(new_data_tokens, maxlen=max_len, padding="post")
    return new_data_padded


# Process predictions
def process_predictions(predictions):
    threshold = 0.2
    processed_predictions = [1 if pred > threshold else 0 for pred in predictions]
    return processed_predictions


# Comment processing function
def commentProcess(new_data):
    # Preprocess the new data
    preprocessed_data = preprocess_new_data(new_data)

    # Make predictions on the preprocessed data
    predictions = model.predict(preprocessed_data)

    # Process the predictions
    processed_predictions = process_predictions(predictions)

    return processed_predictions


# # Example usage
# new_data = "This is a new comment about a leaf disease."

# # Process the comment
# processed_comment = commentProcess(new_data)

# # Print the processed comment
# print(processed_comment[0])
