                        Homepage and Survey Assignment
Name: Suryaprakash Uppalapati
Course: SWE 645

Project Overview
The project includes a personal student homepage and a survey form. Both are deployed on Amazon Web Services using two different methods:- 												S3 static hosting and EC2 web server.

Live Website Links:
               S3 Static Website: https://homepage-suppala-2024.s3.us-east-1.amazonaws.com/index.html
               EC2 Web Server: http://18.234.84.237

AWS Deployment Methods

Method 1: Amazon S3 Static Website
S3 hosting is good for simple websites that don't need server processing. I used these steps:

step 1: Created S3 bucket named "homepage-suppala-2024"
step 2: Uploaded all website files (HTML, CSS, images)
step 3: Turned on static website hosting
step 4: Set index.html as main page and error.html for errors
step 5: Changed permissions so anyone can view the website
step 6: Got the website URL from AWS(http://homepage-suppala-2024.s3-website-us-east-1.amazonaws.com)

Method 2: Amazon EC2 Web Server
EC2 gives you a virtual computer in the cloud. I set it up like this:

step 1: Started a new EC2 instance with Amazon Linux
step 2: Created security groups to allow web traffic(HTTP port 80 and SSH port 22)
step 3: Downloaded the private key file (.pem) for secure access
step 4: Used PuTTYgen to convert .pem key to .ppk format for Windows
step 5: Connected using PuTTY terminal with the .ppk key file
step 6: Installed Apache web server software through command line
step 7: Used WinSCP file transfer program to upload website files to the web directory
step 8: Configured custom error pages in Apache settings
step 9: Tested everything works properly(http://18.234.84.237)

Files in This Project

index.html - Main homepage with my profile and information
survey.html - Student survey form with validation
error.html - Custom error page for broken links
image_swe.jpg - My profile photo
README.md - This file with project information

How to Test the Websites

Test the Homepage:

Visit either website URL
2. Click the Survey link in the navigation menu
3. Make sure the page looks good on mobile phones

Test the Survey Form:

Try submitting the form with empty required fields
2. Enter a phone number in the wrong format
3. Put less than 10 numbers in the raffle field
4. Fill out the form correctly and submit it

Test Error Pages:

Add "/fake-page.html" to either website URL--for S3(http://homepage-suppala-2024.s3-website-us-east-1.amazonaws.com/fake-pge.html)
                                              --for ec2(http://18.234.84.237/fake-page.html)
2. Should show the custom error page instead of a blank screen

