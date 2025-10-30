//
//  main.c
//  getxattr
//
//  Created by Tomasz Kukielka on 6/21/25.
//

#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/xattr.h>

void print_help(void)
{
    fprintf(stdout, "\nNAME\n");
    fprintf(stdout, "\tgetxattr - extract file extended attribute\n\n");
    fprintf(stdout, "SYNOPSIS\n");
    fprintf(stdout, "\tgetxattr <file path> <attribute name> <output file path>\n\n");
}

int
write_data_to_file(void *buffer, ssize_t length, const char *file_path)
{
    // Open a file for writing (create it if it doesn't exist)
    int fd = open(file_path, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    if (fd == -1)
    {
        return 1;
    }
        
    // Write the buffer to the file
    ssize_t bytes_written = write(fd, buffer, length);
    if (bytes_written == -1)
    {
        close(fd);
        return 1;
    }
    
    // Close the file descriptor
    close(fd);
    return 0;
}

int main(int argc, const char * argv[])
{
    if(argc < 4)
    {
        print_help();
        return -1;
    }

    const char *file_path = argv[1];
    const char *attribute_name = argv[2];

    ssize_t data_size = getxattr(file_path, attribute_name, NULL, 0, 0, XATTR_NOFOLLOW);
    printf("data size:\t%zd\n", data_size);
    if(data_size <= 0 )
    {
        return 1;
    }
    
    void *attribute_data = malloc(data_size);
    data_size = getxattr(file_path, attribute_name, attribute_data, data_size, 0 /*position*/, XATTR_NOFOLLOW);
    if(data_size <= 0 )
    {
        return 1;
    }

    const char *out_file_path = argv[3];
    return write_data_to_file(attribute_data, data_size, out_file_path);
}
