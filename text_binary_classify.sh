{
#!/bin/bash

# Specify the weka path as the first argument and the directory containing all files to be compared as the second argument. The results can then be outputed to a certain file with >.

if [[ $# -lt 2 ]]
then
        echo "text_binary_classify.sh needs two arguments: text_binary_classify.sh path_to_weka_directory path_to_files_directory(.arff file)"
        exit 1
fi

if [[ ! -d $1 ]]
then
        echo "path_to_weka_directory does not exist"
fi

if [[ ! -d $2 ]]
then
        echo "path_to_files_directory (.arff file) does not exist"
fi

java weka.core.converters.TextDirectoryLoader -dir $2 > temp_reviews.arff
java -Xmx1024m weka.filters.unsupervised.attribute.StringToWordVector -i temp_reviews.arff -o temp_reviews_training.arff -M 2
java -Xmx1024m weka.classifiers.meta.ClassificationViaRegression -W weka.classifiers.trees.M5P -num-decimal-places 4 -t temp_reviews_training.arff -d temp_reviews_training.model -c 1
}

