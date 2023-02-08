##
# The About panel
# Yang Liu
# 10/27/2019
##
function() {
  tabPanel("About",
           p("This app is maintained by Roxy Yuan,"),

           br(), br(),
           strong("Disclaimer"),
           p("The content in the app doesn't represent any official opinion from any organization."),
           br(), br(),
           p("UNAUTHORIZED PERSON IS NOT ALLOWED \n
             TO USE, COPY, MODIFY, MERGE, PUBLISH, DISTRIBUTE, SUBLICENSE, AND/OR SELL\n
             COPIES OF THE SOFTWARE.\n",
              
            "THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
            IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
            FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
            AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
            LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
            OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
            SOFTWARE."
             ),
           
           
           br(), br(),
           p("Last updated: Oct, 2019",
             br("Created in ",
                a("R", 
                  href = "http://www.r-project.org/", target = "_blank"),
                "| Powered by ",
                a("Shiny", 
                  href = "http://www.rstudio.com/shiny/", target = "_blank")),
             align = "center")
  )
}
